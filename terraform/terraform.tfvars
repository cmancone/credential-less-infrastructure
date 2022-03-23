name                                = "default-gateway"
route_53_hosted_zone_name           = "example.com"
akeyless_gateway_iam_role_arn       = "arn:aws:iam::0123456789012:role/MyRole"
akeyless_gateway_admin_access_id    = "p-access-id"
akeyless_gateway_allowed_access_ids = "p-access-id"

primary_region                         = "us-east-1"
primary_region_domain_name             = "us.gateway.akeyless.example.com"
primary_region_availability_zone_names = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]

secondary_region                         = "eu-west-1"
secondary_region_domain_name             = "eu.gateway.akeyless.example.com"
secondary_region_availability_zone_names = ["eu-west-1a", "eu-west-1b", "eu-west-1c", "eu-west-1d"]

tags = {}
