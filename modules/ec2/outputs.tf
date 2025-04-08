output "public_ec2_instance_id" {
  value = aws_instance.public_ec2.id
}

output "private_ec2_instance_id" {
  value = aws_instance.private_ec2.id
}

output "ec2_instance_profile_name" {
  value = aws_iam_instance_profile.ec2_profile.name
}
