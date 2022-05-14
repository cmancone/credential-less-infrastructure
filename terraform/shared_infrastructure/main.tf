terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    akeyless = {
      version = ">= 1.0.0"
      source  = "akeyless-community/akeyless"
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

module "gateway-ecs" {
  source = "git::https://github.com/cmancone/akeyless-gateway-ecs.git"

  name                        = var.name
  region                      = var.region
  vpc_id                      = module.vpc.id
  public_subnet_ids           = module.vpc.public_subnet_ids
  private_subnet_ids          = module.vpc.private_subnet_ids
  route_53_hosted_zone_name   = var.route_53_hosted_zone_name
  domain_name                 = var.akeyless_gateway_domain_name
  iam_role_name               = var.akeyless_gateway_iam_role_name
  admin_access_id             = akeyless_auth_method_aws_iam.gateway_auth.access_id
  allowed_access_ids          = var.akeyless_gateway_allowed_access_ids
  alb_access_logs_bucket_name = var.alb_access_logs_bucket_name
  desired_task_count          = var.akeyless_gateway_desired_task_count
  tags                        = var.tags

  gateway_ports = { 8000 : 8000, 8200 : 8200, 8080 : 8080, 8081 : 8081, 5696 : 5696 }

  depends_on = [akeyless_associate_role_auth_method.gateway_role_attachment]
}
