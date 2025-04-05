# IAM Role for ECS Task Execution
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "ecs-tasks.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

# IAM Role for EC2 Instance
resource "aws_iam_role" "ec2_role" {
  name = "ec2InstanceRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

# IAM Role for RDS Access
resource "aws_iam_role" "rds_role" {
  name = "rdsAccessRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "rds.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

# Instance Profile for EC2
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2InstanceProfile"
  role = aws_iam_role.ec2_role.name
}

# IAM Policies for S3, RDS, and CloudWatch
resource "aws_iam_policy" "s3_access" {
  name        = "s3AccessPolicy"
  description = "Policy for ECS & EC2 to access S3"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = ["s3:ListBucket", "s3:GetObject", "s3:PutObject"]
      Resource = ["arn:aws:s3:::${var.s3_bucket}", "arn:aws:s3:::${var.s3_bucket}/*"]
    }]
  })
}

resource "aws_iam_policy" "rds_access" {
  name        = "rdsAccessPolicy"
  description = "Policy for ECS & EC2 to access RDS"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = ["rds:DescribeDBInstances", "rds:Connect"]
      Resource = ["*"]
    }]
  })
}

resource "aws_iam_policy" "cloudwatch_access" {
  name        = "cloudWatchAccessPolicy"
  description = "Policy for ECS & EC2 to write logs to CloudWatch"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
      Resource = ["arn:aws:logs:*:*:*"]
    }]
  })
}

# Attach IAM Policies to ECS Task Role
resource "aws_iam_role_policy_attachment" "ecs_s3_attach" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.s3_access.arn
}

resource "aws_iam_role_policy_attachment" "ecs_rds_attach" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.rds_access.arn
}

resource "aws_iam_role_policy_attachment" "ecs_cloudwatch_attach" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.cloudwatch_access.arn
}

# Attach IAM Policies to EC2 Role
resource "aws_iam_role_policy_attachment" "ec2_s3_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_access.arn
}

resource "aws_iam_role_policy_attachment" "ec2_rds_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.rds_access.arn
}

resource "aws_iam_role_policy_attachment" "ec2_cloudwatch_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.cloudwatch_access.arn
}

# Attach IAM Policies to RDS Role
resource "aws_iam_role_policy_attachment" "rds_s3_attach" {
  role       = aws_iam_role.rds_role.name
  policy_arn = aws_iam_policy.s3_access.arn
}

resource "aws_iam_role_policy_attachment" "rds_cloudwatch_attach" {
  role       = aws_iam_role.rds_role.name
  policy_arn = aws_iam_policy.cloudwatch_access.arn
}
