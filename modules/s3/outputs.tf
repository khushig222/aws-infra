output "s3_bucket_name" {
  description = "S3 Bucket Name"
  value       = aws_s3_bucket.app_storage.id
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.app_storage.arn
}

