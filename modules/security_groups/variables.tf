variable "sg_name" {
  description = "Base name for the security groups"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}

variable "allowed_cidr" {
  description = "List of allowed CIDR blocks"
  type        = list(string)
}
