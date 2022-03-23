terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

module "vpc" {
  source = "./vpc"

  name                     = var.name
  availability_zone_names  = var.availability_zone_names
  vpc_flow_log_bucket_name = var.vpc_flow_log_bucket_name
  tags                     = var.tags
}

module "gateway" {
  source = "git::https://github.com/cmancone/akeyless-gateway-ecs.git"

  name                        = var.name
  region                      = var.region
  vpc_id                      = module.vpc.id
  public_subnet_ids           = module.vpc.public_subnet_ids
  private_subnet_ids          = module.vpc.private_subnet_ids
  route_53_hosted_zone_name   = var.route_53_hosted_zone_name
  domain_name                 = var.akeyless_gateway_domain_name
  iam_role_arn                = var.akeyless_gateway_iam_role_arn
  admin_access_id             = var.akeyless_gateway_admin_access_id
  admin_access_key            = var.akeyless_gateway_admin_access_key
  admin_password              = var.akeyless_gateway_admin_password
  allowed_access_ids          = var.akeyless_gateway_allowed_access_ids
  alb_access_logs_bucket_name = var.alb_access_logs_bucket_name
  desired_task_count          = var.akeyless_gateway_desired_task_count
  tags                        = var.tags
}
