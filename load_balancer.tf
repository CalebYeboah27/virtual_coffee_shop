
resource "aws_launch_configuration" "website_launch_config" {
  name          = "web-launch-config"
  image_id      = data.aws_ami.latest_amazon_linux2.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.terraform_ssh_pair.key_name

  lifecycle {
    create_before_destroy = true
  }

  security_groups = [aws_security_group.website_sec_group.id]
}

resource "aws_autoscaling_group" "website_autoscaling_group" {
  desired_capacity     = 2
  max_size             = 3
  min_size             = 1
  launch_configuration = aws_launch_configuration.website_launch_config.id
  vpc_zone_identifier  = [aws_subnet.website.id]
}

resource "aws_lb" "website_alb" {
  name                       = "website-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.website_sec_group.id]
  enable_deletion_protection = false
  subnets                    = [aws_subnet.website.id, aws_subnet.website_az2.id]

  enable_cross_zone_load_balancing = true
  idle_timeout                     = 60

  enable_http2 = true
}

resource "aws_lb_target_group" "website_target_group" {
  name     = "websitetargetgroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
  }
}

resource "aws_lb_listener" "website_alb_listener" {
  load_balancer_arn = aws_lb.website_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.website_target_group.arn
    type             = "forward"
  }
}
