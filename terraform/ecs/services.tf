# DB
resource "aws_ecs_service" "mysql_ecs_service" {
  name            = "mysql-service"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.mysql_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  service_registries {
    registry_arn = aws_service_discovery_service.mysql_service_discovery.arn
  }

  network_configuration {
    subnets         = var.vpc_private_subnets_ids
    security_groups = [aws_security_group.ecs_mysql_sg_service.id]
  }
}

# API
resource "aws_ecs_service" "ecs_api_service" {
  name            = "flask-api-service"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.api_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  service_registries {
    registry_arn = aws_service_discovery_service.api_service_discovery.arn
  }

  network_configuration {
    subnets         = var.vpc_private_subnets_ids
    security_groups = [aws_security_group.ecs_api_sg_service.id]
  }
}

# Frontend
resource "aws_ecs_service" "ecs_nextjs_service" {
  name            = "nextjs-service"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.nextjs_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.vpc_public_subnets_ids
    security_groups = [aws_security_group.ecs_nextjs_sg_service.id]
    assign_public_ip = true
  }
}