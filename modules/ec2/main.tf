resource "aws_instance" "public_ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.public_sg_id]
  key_name               = var.key_name

  associate_public_ip_address = true

  tags = {
    Name = "${var.instance_name}-public"
  }
}

resource "aws_instance" "private_ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.private_sg_id]
  key_name               = var.key_name

  associate_public_ip_address = false  # No public IP for private EC2

  tags = {
    Name = "${var.instance_name}-private"
  }
}
