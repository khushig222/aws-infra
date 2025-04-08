variable "instance_class" {
  description = "RDS instance type"
  type        = string
}

variable "allocated_storage" {
  description = "Storage size for RDS"
  type        = number
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Database admin username"
  type        = string
}

variable "db_password" {
  description = "Database admin password"
  type        = string
  sensitive   = true
}

variable "private_subnet_ids" {
  description = "Private subnets for RDS"
  type        = list(string)
}

variable "rds_sg_id" {
  description = "Security group for RDS"
  type        = string
}
