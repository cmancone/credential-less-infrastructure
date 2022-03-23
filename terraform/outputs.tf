output "primary_vpc_id" {
  value       = module.primary_region.id
  description = "The ID of the VPC in the primary region."
}

output "primary_private_subnet_ids" {
  value       = module.primary_region.private_subnet_ids
  description = "List of subnet ids for private subnets of the VPC in the primary region."
}

output "primary_public_subnet_ids" {
  value       = module.primary_region.public_subnet_ids
  description = "List of subnet ids for public subnets of the VPC in the primary region."
}

output "primary_private_subnet_cidr_blocks" {
  value       = module.primary_region.private_subnet_cidr_blocks
  description = "List of CIDR blocks for the private subnets of the VPC in the primary region."
}

output "primary_public_subnet_cidr_blocks" {
  value       = module.primary_region.public_subnet_cidr_blocks
  description = "List of CIDR blocks for the public subnets of the VPC in the primary region."
}

output "primary_cidr_block" {
  value       = module.primary_region.cidr_block
  description = "The CIDR block for the VPC in the primary region."
}
