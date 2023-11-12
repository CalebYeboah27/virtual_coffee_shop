# main vpc for virtual coffee shop - production webiste
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    "Name" = "Production ${var.main_vpc_name}"
  }
}

# public subnet
resource "aws_subnet" "website" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.website
  map_public_ip_on_launch = true
  availability_zone = "us-west-2a"

  tags = {
    Name = "website subnet"
  }
}

resource "aws_subnet" "website_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.website_az2
  map_public_ip_on_launch = true
  availability_zone = "us-west-2b"

  tags = {
    Name = "website subnet az2"
  }
}


# private subnet
resource "aws_subnet" "backend" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.backend
  map_public_ip_on_launch = false
  availability_zone = "us-west-2c"

  tags = {
    Name = "Backend subnet"
  }
}

resource "aws_internet_gateway" "my_website_igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.main_vpc_name} IGW"
  }
}

resource "aws_default_route_table" "main_vpc_default_rt" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_website_igw.id
  }

  tags = {
    Name = "my-default-rt"
  }
}

resource "aws_route_table_association" "website_subnet_association" {
  subnet_id      = aws_subnet.website.id
  route_table_id = aws_default_route_table.main_vpc_default_rt.id
}

resource "aws_network_interface" "website_instance_nic" {
  subnet_id       = aws_subnet.website.id
  security_groups = [aws_security_group.website_sec_group.id]

  depends_on = [
    aws_instance.website-server,
  ]
}

resource "aws_network_interface_attachment" "website_instance_nic_attachment" {
  instance_id          = aws_instance.website-server.id
  network_interface_id = aws_network_interface.website_instance_nic.id
  device_index         = 1
}
