variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "SSH Key Name"
  type        = string
}

# Subnets dynamically referenced from the VPC module
variable "public_subnet_id" {
  description = "Public subnet ID for frontend EC2"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID for backend EC2"
  type        = string
}

# Security groups dynamically referenced from the SG module
variable "public_sg_id" {
  description = "Security Group ID for public EC2"
  type        = string
}

variable "private_sg_id" {
  description = "Security Group ID for private EC2"
  type        = string
}

variable "instance_name" {
  description = "Prefix for EC2 instance names"
  type        = string
}
