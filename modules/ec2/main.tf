resource "aws_instance" "public_ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.public_sg_id]
  key_name               = var.key_name

  user_data = file("${path.module}/public_user_data.sh")

  # Attach IAM Role
  iam_instance_profile = var.iam_instance_profile 
 

  tags = {
    Name = "Public-EC2-Instance"
  }
}

resource "aws_instance" "private_ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.private_sg_id]
  key_name               = var.key_name

  user_data = file("${path.module}/private_user_data.sh")

  # Attach IAM Role
  iam_instance_profile = var.iam_instance_profile  


  tags = {
    Name = "Private-EC2-Instance"
  }
}


resource "aws_security_group" "public_sg" {
  name   = "public-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group" "private_sg" {
  name   = "private-sg"
  vpc_id = var.vpc_id
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2InstanceProfile"
  role = var.iam_role_name
}

