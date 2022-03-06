module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = ">=3.11.5"

  name = var.name
  cidr = "10.0.0.0/16"

  azs             = var.availability_zone_names
  private_subnets = formatlist("10.0.%d.0/24", range(1, length(var.availability_zone_names)))
  public_subnets  = formatlist("10.0.10%d.0/24", range(1, length(var.availability_zone_names)))

  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_nat_gateway   = true
  single_nat_gateway   = false

  tags = merge(
    { "Name" = var.name },
    var.tags,
  )
}

resource "aws_flow_log" "aws_flowlogs" {
  count                = var.vpc_flow_log_bucket_name != "" ? 1 : 0
  log_destination      = "arn:aws:s3:::${var.vpc_flow_log_bucket_name}/${module.vpc.vpc_id}/"
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = module.vpc.vpc_id
}

resource "aws_default_security_group" "default" {
  vpc_id = module.vpc.id
}
