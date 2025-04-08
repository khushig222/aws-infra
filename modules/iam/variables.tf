variable "iam_role_names" {
  description = "List of IAM roles to create"
  type        = list(string)
  default     = ["ec2-instance-role", "ecs-task-role"]
}
