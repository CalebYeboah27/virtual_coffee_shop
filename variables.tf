variable "vpc_cidr_block" {
  type        = string
  description = "cidr block for the main vpc"
}

variable "website" {
  type        = string
  description = "cidr block for the web subnet"
}

variable "website_az2" {
  type        = string
  description = "cidr block for the web subnet in az2"
}

variable "backend" {
  type        = string
  description = "cidr block for the web subnet"
}

variable "subnet_zone" {
  type        = string
  description = "availability zone for subnet zone"
  # subnet_zone was set as environment variable
}

variable "ssh_public_key" {
  type        = string
  description = "public key that permits ssh connection to the ec2 instance"
}

variable "main_vpc_name" {
  type        = string
  description = "name of the main vpc"
}

variable "my_public_ip" {
  description = "my public ip address"
}