output "rds_endpoint" {
  description = "RDS endpoint for database connection"
  value       = aws_db_instance.rds_instance.endpoint
}

output "rds_instance_id" {
  description = "RDS instance identifier"
  value       = aws_db_instance.rds_instance.id
}

output "rds_subnet_group" {
  description = "RDS subnet group name"
  value       = aws_db_subnet_group.rds_subnet_group.name
}
