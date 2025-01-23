# DB
resource "aws_ecs_task_definition" "mysql_task" {
  family                   = "mysql-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.default_cpu
  memory                   = var.default_memory

  execution_role_arn = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {
      name      = "mysql-db",
      image     = "${var.db_image}",
      essential = true,
      portMappings = [
        {
          containerPort = 3306,
          hostPort      = 3306,
          protocol      = "tcp"
        }
      ],
      secrets = [
        { name = "MYSQL_ROOT_PASSWORD", valueFrom = "arn:aws:secretsmanager:${var.aws_region}:${var.aws_account_id}:secret:${var.db_details_secret}:MYSQL_ROOT_PASSWORD::" },
        { name = "MYSQL_DATABASE", valueFrom = "arn:aws:secretsmanager:${var.aws_region}:${var.aws_account_id}:secret:${var.db_details_secret}:MYSQL_DATABASE::" },
        { name = "MYSQL_USER", valueFrom = "arn:aws:secretsmanager:${var.aws_region}:${var.aws_account_id}:secret:${var.db_details_secret}:MYSQL_USER::" },
        { name = "MYSQL_PASSWORD", valueFrom = "arn:aws:secretsmanager:${var.aws_region}:${var.aws_account_id}:secret:${var.db_details_secret}:MYSQL_PASSWORD::" }
      ],
    }
  ])
}

# API
resource "aws_ecs_task_definition" "api_task" {
  family                   = "api-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.default_cpu
  memory                   = var.default_memory

  execution_role_arn = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {
      name      = "flask-api",
      image     = "${var.api_image}",
      essential = true,
      portMappings = [
        {
          containerPort = 8000,
          hostPort      = 8000,
          protocol      = "tcp"
        }
      ],
      environment = [
        { name = "MYSQL_HOST", value = "${aws_service_discovery_service.mysql_service_discovery.name}.${aws_service_discovery_private_dns_namespace.cluster_namespace.name}" }
      ],
      secrets = [
        { name = "MYSQL_DATABASE", valueFrom = "arn:aws:secretsmanager:${var.aws_region}:${var.aws_account_id}:secret:${var.db_details_secret}:MYSQL_DATABASE::" },
        { name = "MYSQL_USER", valueFrom = "arn:aws:secretsmanager:${var.aws_region}:${var.aws_account_id}:secret:${var.db_details_secret}:MYSQL_USER::" },
        { name = "MYSQL_PASSWORD", valueFrom = "arn:aws:secretsmanager:${var.aws_region}:${var.aws_account_id}:secret:${var.db_details_secret}:MYSQL_PASSWORD::" }
      ]
    }
  ])
}

# Frontend
resource "aws_ecs_task_definition" "nextjs_task" {
  family                   = "nextjs-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.default_cpu
  memory                   = var.default_memory

  execution_role_arn = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {
      name      = "nextjs-frontend",
      image     = "${var.frontend_image}",
      essential = true,
      portMappings = [
        {
          containerPort = 3000,
          hostPort      = 3000,
          protocol      = "tcp"
        }
      ],
      environment = [
        { name = "API_URL", value = "http://${aws_service_discovery_service.api_service_discovery.name}.${aws_service_discovery_private_dns_namespace.cluster_namespace.name}:8000" },
        { name = "NEXT_PUBLIC_API_URL", value = "" }
      ]
    }
  ])
}

output "ecs_mysql_task_definition_arn" {
  value       = aws_ecs_task_definition.mysql_task.arn
  description = "The ARN of the ECS MySQL Task Definition"
}

output "ecs_api_task_definition_arn" {
  value       = aws_ecs_task_definition.api_task.arn
  description = "The ARN of the ECS API Task Definition"
}

output "ecs_nextjs_task_definition_arn" {
  value       = aws_ecs_task_definition.nextjs_task.arn
  description = "The ARN of the ECS Next.js Task Definition"
}