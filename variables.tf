variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
}

variable "project_name" {
  description = "Project name for tagging and resource identification"
  type        = string
}

# VPC Variables
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets_cidrs" {
  description = "List of public subnets CIDR blocks"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "private_subnets_cidrs" {
  description = "List of private subnets CIDR blocks"
  type        = list(string)
}

# EC2 Variables
variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name for EC2 instances"
  type        = string
}

# RDS Variables
variable "instance_class" {
  description = "RDS instance type"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage for RDS (GB)"
  type        = number
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

# ECS Variables
variable "ecs_cluster_name" {
  description = "ECS Cluster Name"
  type        = string
}

variable "task_family" {
  description = "ECS Task Definition Family"
  type        = string
}

variable "cpu" {
  description = "CPU units for ECS task"
  type        = string
}

variable "memory" {
  description = "Memory (MB) for ECS task"
  type        = string
}

variable "container_name" {
  description = "ECS Container Name"
  type        = string
}

variable "container_image" {
  description = "ECS Container Image URL"
  type        = string
}

variable "container_port" {
  description = "ECS Container Port"
  type        = number
}

variable "service_name" {
  description = "ECS Service Name"
  type        = string
}

variable "desired_count" {
  description = "Desired number of ECS service tasks"
  type        = number
}

# S3 Variables
variable "bucket_name" {
  description = "S3 bucket name for storing assets"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM instance profile name for EC2"
  type        = string
}

