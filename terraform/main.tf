terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "always-upgrade-terraform-state"
    key    = "shared-infrastructure.json"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.primary_region
  alias  = "primary_region"
}

module "primary_region" {
  source = "./shared_infrastructure"

  providers = {
    aws = aws.primary_region
  }

  name                      = var.name
  region                    = var.primary_region
  availability_zone_names   = var.primary_region_availability_zone_names
  route_53_hosted_zone_name = var.route_53_hosted_zone_name

  akeyless_aws_iam_access_id          = var.akeyless_aws_iam_access_id
  aws_role_arn_for_producer           = var.aws_role_arn_for_producer
  akeyless_gateway_domain_name        = var.primary_region_domain_name
  akeyless_gateway_iam_role_name      = var.akeyless_gateway_iam_role_name
  akeyless_gateway_allowed_access_ids = var.akeyless_gateway_allowed_access_ids
  akeyless_gateway_desired_task_count = var.akeyless_gateway_desired_task_count
  akeyless_gateway_akeyless_role_name = var.akeyless_gateway_akeyless_role_name
  akeyless_folder                     = var.akeyless_folder

  vpc_flow_log_bucket_name    = var.vpc_flow_log_bucket_name
  alb_access_logs_bucket_name = var.alb_access_logs_bucket_name
  tags                        = var.tags
}

module "github_repo_authentication" {
  source                     = "./github_auth"
  repository_access          = var.repository_access
  akeyless_aws_iam_access_id = var.akeyless_aws_iam_access_id
}
