provider "akeyless" {
  alias = "global-cloud"

  aws_iam_login {
    access_id = "p-1hmqj3uqfkge"
  }
}

provider "akeyless" {
  alias               = "gateway"
  api_gateway_address = "https://us.gateway.akeyless.always-upgrade.us:8081"

  aws_iam_login {
    access_id = "p-1hmqj3uqfkge"
  }
}

data "aws_caller_identity" "current" {}

# Create the auth method our gateway will authenticate with
resource "akeyless_auth_method_aws_iam" "gateway_auth" {
  provider = akeyless.global-cloud

  name                 = "${var.akeyless_folder}/${var.name}"
  bound_aws_account_id = [data.aws_caller_identity.current.account_id]
  bound_role_name      = [var.akeyless_gateway_iam_role_name]
}

# and attach it to the role specified by the user (presumably, some sort of admin-level role)
resource "akeyless_associate_role_auth_method" "gateway_role_attachment" {
  provider = akeyless.global-cloud

  am_name   = "${var.akeyless_folder}/${var.name}"
  role_name = var.akeyless_gateway_akeyless_role_name

  depends_on = [akeyless_auth_method_aws_iam.gateway_auth]
}

# add an AWS target pointing at the Gateways IAM credentials
resource "akeyless_target_aws" "target_aws_self" {
  provider = akeyless.gateway

  access_key_id         = "notanid"
  name                  = "${var.akeyless_folder}/gateway-self"
  use_gw_cloud_identity = true

  depends_on = [akeyless_auth_method_aws_iam.gateway_auth]
}

# add an AWS producer to generate admin credentials
resource "akeyless_producer_aws" "admin" {
  provider = akeyless.gateway

  name                         = "${var.akeyless_folder}/aws-admin"
  access_mode                  = "assume_role"
  target_name                  = akeyless_target_aws.target_aws_self.name
  region                       = var.region
  aws_role_arns                = var.aws_role_arn_for_producer
  aws_user_programmatic_access = true
}
