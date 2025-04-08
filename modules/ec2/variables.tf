variable "ami_id" {
  description = "AMI ID for the instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID (From VPC Module)"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID (From VPC Module)"
  type        = string
}

variable "public_sg_id" {
  description = "Security Group ID for Public EC2"
  type        = string
}

variable "private_sg_id" {
  description = "Security Group ID for Private EC2"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
  default = "rds-key"
}

variable "vpc_id" {
  description = "ID of the VPC where resources will be created"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM instance profile for EC2"
  type        = string
}

variable "iam_role_name" {
  description = "IAM Role Name for EC2"
  type        = string
}
