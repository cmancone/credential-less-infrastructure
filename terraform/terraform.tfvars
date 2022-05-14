# A descriptive name for the service (or whatever) that we're working with
name = "products"

# The name of the Route53 hosted zone that our domain will live "under"
route_53_hosted_zone_name = "example.com"

# The ARN for the AWS role that our gateway/producer will generate temporary credentials for
aws_role_arn_for_producer = "arn:aws:iam::[YOUR_ACCOUNT_ID]:role/admin"

# The AWS IAM auth access id that terraform should use to login to AKeyless with
akeyless_aws_iam_access_id = "p-123456789012"

# The folder in AKeyless that everything for our service lives under
akeyless_folder = "/services/products/production"

# The name of the role in AKeyless that contains the AKeyless permissions for the Gateway - the Gateway auth method will be attached to this.
akeyless_gateway_akeyless_role_name = "/services/products/production/admin"

# The Access ids that you want to use to login to the configuration page of your Gateway.
# For this demo, there are two access ids: one corresponding to the AWS IAM auth method for the AWS "admin",
# and one for SAML users.  Note that you can specify subclaims here (see ALLOWED_ACCESS_IDS in this page:
# https://docs.akeyless.io/docs/using-environment-variables)
akeyless_gateway_allowed_access_ids = "p-111111111111,p-222222222222"

# The region we want to deploy to (AKeyless makes multi-region deployments easy, but I haven't set that up here)
primary_region = "us-east-1"

# The domain name to host the gateway on (must be "under" your Route53 hosted zone)
primary_region_domain_name = "us.gateway.akeyless.example.com"

# The AZs to deploy to
primary_region_availability_zone_names = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]

# Any tags that you would like to attach to the resources.
tags = {}

# our repository access map
repository_access = []
