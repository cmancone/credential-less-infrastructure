output "id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC."
}

output "private_subnet_ids" {
  value       = module.vpc.private_subnets
  description = "List of subnet ids for private subnets"
}

output "public_subnet_ids" {
  value       = module.vpc.public_subnets
  description = "List of subnet ids for public subnets"
}

output "private_subnet_cidr_blocks" {
  value       = module.vpc.private_subnets_cidr_blocks
  description = "List of CIDR blocks for the private subnets"
}

output "public_subnet_cidr_blocks" {
  value       = module.vpc.public_subnets_cidr_blocks
  description = "List of CIDR blocks for the public subnets"
}

output "cidr_block" {
  value       = module.vpc.vpc_cidr_block
  description = "The CIDR block for the VPC"
}
