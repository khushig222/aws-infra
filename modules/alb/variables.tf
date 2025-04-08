variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "alb_sg_id" {
  description = "Security Group ID for ALB"
  type        = string
}

variable "public_ec2_id" {
  description = "Public EC2 instance ID for frontend"
  type        = string
}

variable "private_ec2_id" {
  description = "Private EC2 instance ID for backend"
  type        = string
}
