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

output "gateway_iam_auth_access_id" {
  value       = akeyless_auth_method_aws_iam.gateway_auth.access_id
  description = "The Access ID of the gateway's IAM auth method"
}

###
### These will only work after we uncomment the bottom half of akeyless.tf
###
/*
output "aws_target_gateway" {
  value       = akeyless_target_aws.target_aws.name
  description = "The name of the AWS target for AWS producers to use"
}

output "aws_producer_name" {
  value       = akeyless_producer_aws.admin.name
  description = "The path to the AWS producer"
}
*/
