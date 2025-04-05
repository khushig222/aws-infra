# Create ECS Cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name
}

# ECS Task Definition (Single Image for Both Frontend & Backend)
resource "aws_ecs_task_definition" "app_task" {
  family                   = "app-task"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  cpu                      = var.task_cpu
  memory                   = var.task_memory

  container_definitions = jsonencode([
    {
      name  = "app"
      image = var.app_image
      cpu   = var.task_cpu
      memory = var.task_memory
      portMappings = [
        {
          containerPort = var.frontend_port
          hostPort      = var.frontend_port
        },
        {
          containerPort = var.backend_port
          hostPort      = var.backend_port
        }
      ]
      environment = [
        {
          name  = "DB_HOST"
          value = var.rds_endpoint
        },
        {
          name  = "DB_USER"
          value = var.db_user
        },
        {
          name  = "DB_PASS"
          value = var.db_pass
        }
      ]
    }
  ])
}

# ECS Service (Single Service for Both Frontend & Backend)
resource "aws_ecs_service" "app_service" {
  name            = "app-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.app_task.arn
  desired_count   = var.desired_count
  launch_type     = "EC2"
}
