# public NACL for website

resource "aws_network_acl" "website_nacl" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = [aws_subnet.website.id]
  # allow ingress port 22
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  # allow ingress port 80 
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  # allow ingress ephemeral ports 
  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 8080
    to_port    = 8080
  }

  # allow egress port 22 
  egress {
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
  }


  tags = {
    Name = "Website_NACL"
  }
}

# public NACL for website

resource "aws_network_acl" "backend_nacl" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = [aws_subnet.backend.id]
  # allow ingress port 22
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  # deny ingress port 80 
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  # deny ingress ephemeral ports 
  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }


  tags = {
    Name = "Backend_NACL"
  }
}

# resource "aws_subnet_network_acl_association" "public_subnet_nacl_association" {
#   subnet_id      = aws_subnet.webiste.id
#   network_acl_id = aws_network_acl.webiste_nacl.id
# }

# resource "aws_subnet_network_acl_association" "private_subnet_nacl_association" {
#   subnet_id      = aws_subnet.backend_subnet.id
#   network_acl_id = aws_network_acl.backend_nacl.id
# }