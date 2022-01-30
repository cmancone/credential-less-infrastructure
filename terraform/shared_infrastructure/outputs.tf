output "id" {
  value       = module.vpc.id
  description = "The ID of the VPC."
}

output "private_subnet_ids" {
  value       = module.vpc.private_subnet_ids
  description = "List of subnet ids for private subnets of the VPC"
}

output "public_subnet_ids" {
  value       = module.vpc.public_subnet_ids
  description = "List of subnet ids for public subnets of the VPC"
}

output "private_subnet_cidr_blocks" {
  value       = module.vpc.private_subnet_cidr_blocks
  description = "List of CIDR blocks for the private subnets of the VPC"
}

output "public_subnet_cidr_blocks" {
  value       = module.vpc.public_subnet_cidr_blocks
  description = "List of CIDR blocks for the public subnets of the VPC"
}

output "cidr_block" {
  value       = module.vpc.cidr_block
  description = "The CIDR block for the VPC"
}
