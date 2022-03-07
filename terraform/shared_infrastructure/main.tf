module "vpc" {
  source = "./vpc"

  name                     = var.name
  availability_zone_names  = var.availability_zone_names
  vpc_flow_log_bucket_name = var.vpc_flow_log_bucket_name
  tags                     = var.tags
}

module "gateway" {
  source = "./akeyless_gateway"

  name                        = var.name
  vpc_id                      = module.vpc.id
  public_subnet_ids           = module.vpc.public_subnet_ids
  private_subnet_ids          = module.vpc.private_subnet_ids
  route_53_hosted_zone_name   = var.route_53_hosted_zone_name
  domain_name                 = var.akeyless_gateway_domain_name
  iam_role_arn                = var.akeyless_gateway_iam_role_arn
  admin_access_id             = var.akeyless_gateway_admin_access_id
  allowed_access_ids          = var.akeyless_gateway_allowed_access_ids
  alb_access_logs_bucket_name = var.alb_access_logs_bucket_name
  tags                        = var.tags
}