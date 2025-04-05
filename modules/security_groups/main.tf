# Security Group for Public EC2 & ALB
resource "aws_security_group" "public_sg" {
  name        = "${var.sg_name}-public"
  description = "Security group for Public EC2 & ALB"
  vpc_id      = var.vpc_id

  # Allow HTTP and HTTPS
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr
  }

  # Allow SSH for Public EC2 (Optional)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr
  }

  # Allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.sg_name}-public" }
}

# Security Group for Private EC2
resource "aws_security_group" "private_sg" {
  name        = "${var.sg_name}-private"
  description = "Security group for Private EC2"
  vpc_id      = var.vpc_id

  # Allow HTTP traffic from ALB & Public EC2
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.public_sg.id, aws_security_group.alb_sg.id]
  }

  # Allow Backend API Port (5000) from ALB
  ingress {
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  # Allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.sg_name}-private" }
}

# Security Group for ALB
resource "aws_security_group" "alb_sg" {
  name        = "${var.sg_name}-alb"
  description = "Security group for ALB"
  vpc_id      = var.vpc_id

  # Allow HTTP & HTTPS traffic from the internet
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.sg_name}-alb" }
}

# Security Group for ECS
resource "aws_security_group" "ecs_sg" {
  name        = "${var.sg_name}-ecs"
  description = "Security group for ECS"
  vpc_id      = var.vpc_id

  # Allow traffic from ALB
  ingress {
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.sg_name}-ecs" }
}

# Security Group for RDS (Private)
resource "aws_security_group" "rds_sg" {
  name        = "${var.sg_name}-rds"
  description = "Security group for RDS (private)"
  vpc_id      = var.vpc_id

  # Allow MySQL traffic from ECS & Private EC2
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_sg.id, aws_security_group.private_sg.id]
  }

  # Allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.sg_name}-rds" }
}
