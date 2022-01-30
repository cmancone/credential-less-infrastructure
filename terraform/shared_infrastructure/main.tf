module "vpc" {
  source = "./vpc"

  name                    = var.name
  availability_zone_names = var.availability_zone_names
  tags                    = var.tags
}
