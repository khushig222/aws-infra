output "web_alb_sg_id" {
  value = aws_security_group.web_alb_sg.id
}

output "web_server_sg_id" {
  value = aws_security_group.web_server_sg.id
}

output "app_server_sg_id" {
  value = aws_security_group.app_server_sg.id
}

output "database_sg_id" {
  value = aws_security_group.app_servers_sg.id
}

output "ecs_sg_id" {
  value = aws_security_group.ecs_sg.id
}
