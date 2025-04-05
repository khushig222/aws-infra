terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

module "vpc" {
  source         = "aws-infra/modules/vpc"
  vpc_cidr       = var.vpc_cidr
  public_subnet  = var.public_subnet
  private_subnet = var.private_subnet
}

module "security_groups" {
  source       = "aws-infra/modules/security-groups"
  vpc_id       = module.vpc.vpc_id
  sg_name      = var.sg_name
  allowed_cidr = var.allowed_cidr
}

module "ec2" {
  source             = "aws-infra/modules/ec2"
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  key_name           = var.key_name
  public_subnet_id   = module.vpc.public_subnet_ids[0]
  private_subnet_id  = module.vpc.private_subnet_ids[0]
  public_sg_id       = module.security_groups.public_sg_id
  private_sg_id      = module.security_groups.private_sg_id
  instance_name      = var.instance_name
}

module "rds" {
  source                = "aws-infra/modules/rds"
  db_instance_id        = var.db_instance_id
  db_username           = var.db_username
  db_password           = var.db_password
  db_name               = var.db_name
  db_subnet_group       = module.vpc.db_subnet_group_name
  vpc_security_group_ids = [module.security_groups.rds_sg_id]
}

module "alb" {
  source           = "aws-infra/modules/alb"
  vpc_id           = module.vpc.vpc_id
  public_sg_id     = module.security_groups.public_sg_id
  public_subnet_ids = module.vpc.public_subnet_ids
}

module "ecs" {
  source            = "aws-infra/modules/ecs"
  cluster_name      = var.ecs_cluster_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
}

module "iam" {
  source = "aws-infra/modules/iam"
}

module "s3" {
  source      = "aws-infra/modules/s3"
  bucket_name = var.s3_bucket_name
}
