variable "ecs_cluster_name" {
  default     = "my-cluster"
  description = "Name of the ECS cluster"
}

variable "default_cpu" {
  default     = "256"
  description = "Default CPU for the ECS task"
}

variable "default_memory" {
  default     = "512"
  description = "Default memory for the ECS task"
}

variable "db_image" {
  default     = "teodor55/mysql-db:latest"
  description = "The MySQL image name"
}

variable "api_image" {
  default     = "teodor55/flask-api:latest"
  description = "The API image name"
}

variable "frontend_image" {
  default     = "teodor55/nextjs-frontend:latest"
  description = "The API image name"
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "vpc_public_subnets_ids" {
  description = "The IDs of the public subnets"
  type        = list(string)
}

variable "vpc_private_subnets_ids" {
  description = "The IDs of the private subnets"
  type        = list(string)
}

variable "aws_region" {
  description = "The AWS region"
  type        = string
}

variable "aws_account_id" {
  description = "The AWS account ID"
  type        = string
}