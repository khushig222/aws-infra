output "ecs_task_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

output "ec2_instance_profile" {
  description = "Instance profile for EC2"
  value       = aws_iam_instance_profile.ec2_instance_profile.arn
}

output "rds_role_arn" {
  description = "ARN of the RDS access role"
  value       = aws_iam_role.rds_role.arn
}
