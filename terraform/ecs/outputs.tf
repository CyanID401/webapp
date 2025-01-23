output "cluser_id" {
  value = aws_ecs_cluster.my_cluster.id
  description = "The ID of the ECS Cluster"
}

output "cluster_namespace_name" {
  value = aws_service_discovery_private_dns_namespace.cluster_namespace.name
  description = "The name of the ECS Cluster Namespace"
}

output "mysql_service_discovery_arn" {
  value = aws_service_discovery_service.mysql_service_discovery.arn
  description = "The ARN of the ECS MySQL Service Discovery"
}

output "mysql_service_discovery_name" {
  value = aws_service_discovery_service.mysql_service_discovery.name
  description = "The name of the ECS MySQL Service Discovery"
}

output "api_service_discovery_arn" {
  value = aws_service_discovery_service.api_service_discovery.arn
  description = "The ARN of the ECS API Service Discovery"
}

output "api_service_discovery_name" {
  value = aws_service_discovery_service.api_service_discovery.name
  description = "The name of the ECS API Service Discovery"
}