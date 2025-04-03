module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

module "ec2" {
  source         = "./modules/ec2"
  ami            = var.ami
  instance_type  = var.instance_type
  subnet_id      = module.vpc.public_subnet_id
  security_group = module.vpc.default_sg
}

module "rds" {
  source         = "./modules/rds"
  storage        = var.db_storage
  instance_class = var.db_instance_class
  username       = var.db_username
  password       = var.db_password
}

module "ecs" {
  source = "./modules/ecs"
}

module "iam" {
  source = "./modules/iam"
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
}

module "alb" {
  source = "./modules/alb"

  security_groups = [module.vpc.default_sg]
  subnets         = module.vpc.public_subnet_ids
}
