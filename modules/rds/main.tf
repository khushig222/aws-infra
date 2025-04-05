# Fetch the private subnets from the VPC module
data "aws_subnets" "private_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

# Create RDS Subnet Group (Uses Private Subnets from Terraform)
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.env}-rds-subnet-group"
  subnet_ids = data.aws_subnets.private_subnets.ids

  tags = {
    Name        = "${var.env}-rds-subnet-group"
    Environment = var.env
  }
}

# Fetch the RDS Security Group created by Terraform
data "aws_security_group" "rds_sg" {
  filter {
    name   = "group-name"
    values = ["${var.env}-rds-sg"]
  }
}

# Create RDS Instance
resource "aws_db_instance" "rds_instance" {
  identifier             = "${var.env}-rds-instance"
  engine                = "mysql"
  engine_version        = var.db_version
  instance_class        = var.db_instance_type
  allocated_storage     = var.db_storage
  max_allocated_storage = var.db_max_storage
  db_name               = var.db_name
  username              = var.db_user
  password              = var.db_password
  parameter_group_name  = aws_db_parameter_group.rds_params.name
  db_subnet_group_name  = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [data.aws_security_group.rds_sg.id]

  # High Availability (Multi-AZ Deployment)
  multi_az               = var.multi_az
  storage_encrypted      = true
  backup_retention_period = var.backup_retention
  deletion_protection    = true
  skip_final_snapshot    = false

  tags = {
    Name        = "${var.env}-rds-instance"
    Environment = var.env
  }
}
