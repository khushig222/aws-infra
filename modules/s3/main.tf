resource "aws_s3_bucket" "app_storage" {
  bucket = var.bucket_name
}

# Block Public Access
resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket                  = aws_s3_bucket.app_storage.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable Versioning
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.app_storage.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable Server-Side Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.app_storage.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Lifecycle Policy (Move old files to Glacier after 30 days)
resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.app_storage.id

  rule {
    id     = "log-archive"
    status = "Enabled"

    filter {
      prefix = "logs/"  
    }

    transition {
      days          = 30
      storage_class = "GLACIER"
    }

    transition {
      days          = 120
      storage_class = "DEEP_ARCHIVE"
    }
  }
  depends_on = [aws_s3_bucket.app_storage]
}
