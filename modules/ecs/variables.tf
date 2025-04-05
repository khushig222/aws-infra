variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "app_image" {
  description = "Docker image for both frontend and backend"
  type        = string
}

variable "task_cpu" {
  description = "CPU units for task"
  type        = number
}

variable "task_memory" {
  description = "Memory for task"
  type        = number
}

variable "frontend_port" {
  description = "Port for frontend container"
  type        = number
}

variable "backend_port" {
  description = "Port for backend container"
  type        = number
}

variable "desired_count" {
  description = "Number of ECS service tasks"
  type        = number
}

variable "rds_endpoint" {
  description = "RDS database endpoint"
  type        = string
}

variable "db_user" {
  description = "Database username"
  type        = string
}

variable "db_pass" {
  description = "Database password"
  type        = string
}
