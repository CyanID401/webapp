variable "aws_region" {
  default     = "eu-north-1"
  description = "The AWS region"
}


variable "aws_account_id" {
  default     = "307946645974"
  description = "The AWS account ID"
}

variable "azs" {
  type        = list(any)
  default     = ["eu-north-1a", "eu-north-1b"]
  description = "List of Availability Zones"
}

variable "vpc_name" {
  default     = "my-vpc"
  description = "Name of the VPC"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "CIDR block of the VPC"
}

variable "public_subnets_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
  description = "CIDR block for Public Subnets"
}

variable "private_subnets_cidr" {
  type        = list(string)
  default     = ["10.0.9.0/24", "10.0.10.0/24"]
  description = "CIDR block for Private Subnets"
}