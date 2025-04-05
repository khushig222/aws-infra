# Create an S3 Bucket
resource "aws_s3_bucket" "app_bucket" {
  bucket        = "${var.env}-app-bucket-${random_string.suffix.result}"
  force_destroy = true

  tags = {
    Name        = "${var.env}-app-bucket"
    Environment = var.env
  }
}

# Random suffix to ensure unique bucket name
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# Block Public Access
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.app_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable Versioning
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.app_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable Server-Side Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.app_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Lifecycle Policy (Move to Glacier & Delete Old Files)
resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.app_bucket.id

  rule {
    id     = "move-to-glacier"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "GLACIER"
    }

    transition {
      days          = 90
      storage_class = "DEEP_ARCHIVE"
    }

    expiration {
      days = 365
    }
  }
}
