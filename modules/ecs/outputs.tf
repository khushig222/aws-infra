output "ecs_cluster_id" {
  description = "ID of the ECS cluster"
  value       = aws_ecs_cluster.ecs_cluster.id
}

output "task_definition_arn" {
  description = "ARN of ECS task definition"
  value       = aws_ecs_task_definition.app_task.arn
}

output "service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.app_service.name
}
