module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = ">=3.11.5"

  name = var.name
  cidr = "10.0.0.0/16"

  azs             = var.availability_zone_names
  private_subnets = formatlist("10.0.%d.0/24", range(1, length(var.availability_zone_names)))
  public_subnets  = formatlist("10.0.10%d.0/24", range(1, length(var.availability_zone_names)))

  enable_nat_gateway = true

  tags = merge(
    { "Name" = var.name },
    var.tags,
  )
}

resource "aws_default_security_group" "default" {
  vpc_id = module.vpc.id
}

