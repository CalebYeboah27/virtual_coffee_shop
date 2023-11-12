
# Create a new Key Pair
resource "aws_key_pair" "terraform_ssh_pair" {
  key_name   = "terraform_rsa"
  public_key = file(var.ssh_public_key)
}


data "aws_ami" "latest_amazon_linux2" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-x86_64-gp2"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}


# EC2 instance for the website server
resource "aws_instance" "website-server" {
  ami                    = data.aws_ami.latest_amazon_linux2.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.website.id
  vpc_security_group_ids = [aws_security_group.website_sec_group.id]


  associate_public_ip_address = false
  user_data                   = file("script.sh")
  key_name                    = aws_key_pair.terraform_ssh_pair.key_name
  tags = {
    "Name" : "Website Server"
  }
}

# EC2 instance for the backend server
resource "aws_instance" "backend-server" {
  ami                    = data.aws_ami.latest_amazon_linux2.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.backend.id
  vpc_security_group_ids = [aws_security_group.backend_sec_group.id]
  key_name               = aws_key_pair.terraform_ssh_pair.key_name
  tags = {
    "Name" : "Backend Server"
  }
}



