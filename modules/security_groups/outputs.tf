output "public_sg_id" {
  description = "Security Group ID for Public EC2 & ALB"
  value       = aws_security_group.public_sg.id
}

output "private_sg_id" {
  description = "Security Group ID for Private EC2"
  value       = aws_security_group.private_sg.id
}

output "alb_sg_id" {
  description = "Security Group ID for ALB"
  value       = aws_security_group.alb_sg.id
}

output "ecs_sg_id" {
  description = "Security Group ID for ECS"
  value       = aws_security_group.ecs_sg.id
}

output "rds_sg_id" {
  description = "Security Group ID for RDS"
  value       = aws_security_group.rds_sg.id
}
