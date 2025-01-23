resource "aws_ecs_cluster" "my_cluster" {
  name = var.ecs_cluster_name
}

# Create a Service Discovery Namespace
resource "aws_service_discovery_private_dns_namespace" "cluster_namespace" {
  name        = "cluster.local"
  description = "Private DNS namespace for ECS services"
  vpc         = var.vpc_id
}

# Create ECS Service Discovery for Services
resource "aws_service_discovery_service" "mysql_service_discovery" {
  name        = "mysql-service"
  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.cluster_namespace.id
    dns_records {
      ttl  = 60
      type = "A"
    }
  }
}

resource "aws_service_discovery_service" "api_service_discovery" {
  name        = "api-service"
  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.cluster_namespace.id
    dns_records {
      ttl  = 60
      type = "A"
    }
  }
}