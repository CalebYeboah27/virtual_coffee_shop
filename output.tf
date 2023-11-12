output "elastic_ip" {
  description = "The elastic IP address of the public ec2 instance"
  value       = aws_instance.website-server.public_ip
}