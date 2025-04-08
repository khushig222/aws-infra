aws_region   = "us-east-1"
project_name = "myapp"

# VPC Configuration
vpc_name              = "custom-vpc"
vpc_cidr              = "10.0.0.0/16"
public_subnets_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones    = ["us-east-1a", "us-east-1b"]


# EC2 Configuration
ami_id        = "ami-084568db4383264d4"
instance_type = "t3.micro"
key_name      = "rds-key"
iam_instance_profile = "ec2-instance-profile"

# RDS Configuration
instance_class    = "db.t3.micro"
allocated_storage = 20
db_name           = "mydb"
db_username       = "admin"
db_password       = "newpassword"

# ECS Configuration
ecs_cluster_name = "myapp-cluster"
task_family      = "myapp-task"
cpu              = "512"
memory           = "1024"
container_name   = "app-container"
container_image  = "1234567890.dkr.ecr.us-east-1.amazonaws.com/myecr-repo:ecr"
container_port   = 8080
service_name     = "app-service"
desired_count    = 2

# S3 Configuration
bucket_name = "app-storage-bucket-khushi"
