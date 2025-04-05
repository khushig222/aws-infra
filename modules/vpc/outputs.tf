output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.custom_vpc.id
}

output "public_subnets" {
  description = "List of created public subnets"
  value       = aws_subnet.public_subnet[*].id
}

output "private_subnets" {
  description = "List of created private subnets"
  value       = aws_subnet.private_subnet[*].id
}
