output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet[0].id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}

output "default_sg" {
  value = aws_security_group.default_sg.id
}
