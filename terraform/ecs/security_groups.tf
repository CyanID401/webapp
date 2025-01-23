# DB
resource "aws_security_group" "ecs_mysql_sg_service" {
  name_prefix = "ecs-mysql-sg-service-"
  vpc_id  = var.vpc_id

    ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# API
resource "aws_security_group" "ecs_api_sg_service" {
  name_prefix = "ecs-api-sg-service-"
  vpc_id  = var.vpc_id

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Frontend
resource "aws_security_group" "ecs_nextjs_sg_service" {
  name_prefix = "ecs-nextjs-sg-service-"
  vpc_id  = var.vpc_id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "ecs_mysql_sg_service_id" {
  value = aws_security_group.ecs_mysql_sg_service.id
  description = "The ID of the ECS MySQL Security Group"
}

output "ecs_api_sg_service_id" {
  value = aws_security_group.ecs_api_sg_service.id
  description = "The ID of the ECS API Security Group"
}

output "ecs_nextjs_sg_service_id" {
  value = aws_security_group.ecs_nextjs_sg_service.id
  description = "The ID of the ECS NextJS Security Group"
}