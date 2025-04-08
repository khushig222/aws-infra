module "vpc" {
  source               = "./modules/vpc"
  vpc_name             = var.vpc_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnets_cidrs
  private_subnet_cidrs = var.private_subnets_cidrs
  availability_zones   = var.availability_zones
}


module "security_groups" {
  source       = "./modules/security-groups"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}


module "ec2" {
  source            = "./modules/ec2"
  vpc_id            = module.vpc.vpc_id
  ami_id            = "ami-084568db4383264d4"
  instance_type     = "t3.micro"
  public_subnet_id  = module.vpc.public_subnet_ids[0]
  private_subnet_id = module.vpc.private_subnet_ids[0]
  public_sg_id      = module.security_groups.web_server_sg_id
  private_sg_id     = module.security_groups.app_server_sg_id
  key_name          = "rds-key"
  # Attach IAM Role
  iam_instance_profile = module.iam.ec2_instance_profile_name
  iam_role_name        = module.iam.ec2_role_name
}


module "rds" {
  source             = "./modules/rds"
  instance_class     = "db.t3.micro"
  allocated_storage  = 20
  db_name            = "mydb"
  db_username        = "admin"
  db_password        = "newpassword"
  private_subnet_ids = module.vpc.private_subnet_ids
  rds_sg_id          = module.security_groups.database_sg_id
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id         = module.security_groups.web_alb_sg_id
  public_ec2_id     = module.ec2.public_ec2_instance_id
  private_ec2_id    = module.ec2.private_ec2_instance_id
}


module "ecs" {
  source               = "./modules/ecs"
  ecs_cluster_name     = var.ecs_cluster_name
  task_family          = var.task_family
  execution_role_arn   = module.iam.execution_role_arn
  task_role_arn        = module.iam.task_role_arn
  cpu                  = "512"
  memory               = "1024"
  container_name       = "app-container"
  container_image      = "1234567890.dkr.ecr.us-east-1.amazonaws.com/myecr-repo:ecr"
  container_port       = 8080
  service_name         = "app-service"
  desired_count        = 2
  private_subnets      = module.vpc.private_subnet_ids
  ecs_security_group   = module.security_groups.ecs_sg_id
  alb_target_group_arn = module.alb.target_group_arn
}


module "iam" {
  source = "./modules/iam"
}


module "s3" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
}

