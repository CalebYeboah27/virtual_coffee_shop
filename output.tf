output "alb_dns_name" {
  description = "The dns name for the elastic load balancer"
  value       = aws_lb.website_alb.dns_name
}