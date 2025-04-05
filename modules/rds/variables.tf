variable "env" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID created by Terraform"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_user" {
  description = "Database admin username"
  type        = string
}

variable "db_password" {
  description = "Database admin password"
  type        = string
  sensitive   = true
}

variable "db_version" {
  description = "MySQL engine version"
  type        = string
  default     = "8.0"
}

variable "db_instance_type" {
  description = "Instance type for RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "db_storage" {
  description = "Initial allocated storage in GB"
  type        = number
  default     = 20
}

variable "db_max_storage" {
  description = "Maximum storage allowed in GB"
  type        = number
  default     = 100
}

variable "multi_az" {
  description = "Enable multi-AZ deployment for high availability"
  type        = bool
  default     = false
}

variable "backup_retention" {
  description = "Number of days to retain backups"
  type        = number
  default     = 7
}
