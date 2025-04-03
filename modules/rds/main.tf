resource "aws_db_instance" "rds" {
allocated_storage = var.storage
engine = "mysql"
instance_class = var.instance_class
username = var.username
password = var.password
publicly_accessible = false
}