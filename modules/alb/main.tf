resource "aws_lb" "alb" {
  name               = "alb-main"
  internal           = false  
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets  
}
