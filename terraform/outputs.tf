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

output "gateway_iam_auth_access_id" {
  value       = module.primary_region.gateway_iam_auth_access_id
  description = "The Access ID of the gateway's IAM auth method"
}

output "github_access_id" {
  value       = module.github_repo_authentication.github_access_id
  description = "The Access ID of the OAuth2 method to be used by Github Actions"
}

###
### These will only work after we uncomment the bottom half of akeyless.tf
###
/*
output "aws_target_gateway_own_credentials" {
  value       = module.primary_region.aws_target_gateway_own_credentials
  description = "The name of the AWS target that corresponds to the gateways own credentials"
}

output "aws_producer_name" {
  value       = module.primary_region.aws_producer_name
  description = "The path to the AWS producer"
}
*/
