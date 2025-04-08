# Create ALB
resource "aws_lb" "app_lb" {
  name               = "app-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnet_ids

  tags = {
    Name = "Application Load Balancer"
  }
}

# Create Target Group for Frontend
resource "aws_lb_target_group" "frontend_tg" {
  name     = "frontend-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Create Target Group for Backend
resource "aws_lb_target_group" "backend_tg" {
  name     = "backend-target-group"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# # Attach Public EC2 to Frontend Target Group
# resource "aws_lb_target_group_attachment" "frontend_attachment" {
#   target_group_arn = aws_lb_target_group.frontend_tg.arn
#   target_id        = var.public_ec2_id
#   port            = 80
# }

# # Attach Private EC2 to Backend Target Group
# resource "aws_lb_target_group_attachment" "backend_attachment" {
#   target_group_arn = aws_lb_target_group.backend_tg.arn
#   target_id        = var.private_ec2_id
#   port            = 3000
# }

# Create ALB Listener for Frontend
resource "aws_lb_listener" "frontend_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_tg.arn
  }
}

# Create ALB Listener for Backend
resource "aws_lb_listener" "backend_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_tg.arn
  }
}
