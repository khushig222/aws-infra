output "ec2_iam_role_arn" {
  description = "IAM Role ARN for EC2"
  value       = aws_iam_role.ec2_role.arn
}

output "ecs_iam_role_arn" {
  description = "IAM Role ARN for ECS tasks"
  value       = aws_iam_role.ecs_task_role.arn
}

output "execution_role_arn" {
  value =  aws_iam_role.ecs_execution_role.arn
}

output "task_role_arn" {
  value = aws_iam_role.ecs_task_role.arn
}

output "ec2_instance_profile_name" {
  value = aws_iam_instance_profile.ec2_profile.name
}

output "ec2_role_name" {
  value = aws_iam_role.ec2_role.name
}

