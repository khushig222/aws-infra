variable "ecs_cluster_name" {
  description = "ECS cluster name"
  type        = string
}

variable "task_family" {
  description = "ECS Task Family"
  type        = string
}

variable "execution_role_arn" {
  description = "IAM Role for ECS Execution"
  type        = string
}

variable "task_role_arn" {
  description = "IAM Role for ECS Tasks"
  type        = string
}

variable "cpu" {
  description = "Task CPU"
  type        = number
}

variable "memory" {
  description = "Task Memory"
  type        = number
}

variable "container_name" {
  description = "Container name"
  type        = string
}

variable "container_image" {
  description = "Docker Image for the container"
  type        = string
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
}

variable "service_name" {
  description = "ECS Service Name"
  type        = string
}

variable "desired_count" {
  description = "Number of tasks running"
  type        = number
}

variable "private_subnets" {
  description = "Private Subnets for ECS"
  type        = list(string)
}

variable "ecs_security_group" {
  description = "Security Group for ECS Tasks"
  type        = string
}

variable "alb_target_group_arn" {
  description = "Target Group ARN for ALB"
  type        = string
}
