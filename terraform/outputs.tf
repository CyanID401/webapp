output "aws_region" {
  value       = var.aws_region
  description = "The AWS region"
}

output "aws_account_id" {
  value       = var.aws_account_id
  description = "The AWS account ID"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC"
}

output "vpc_public_subnets_ids" {
  value       = module.vpc.public_subnets
  description = "The IDs of the public subnets"
}

output "vpc_private_subnets_ids" {
  value       = module.vpc.private_subnets
  description = "The IDs of the private subnets"
}

output "frontend_alb_dns_name" {
  value       = module.ecs.frontend_alb_dns_name
  description = "The DNS name of the ALB"
}