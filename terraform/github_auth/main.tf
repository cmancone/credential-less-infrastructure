terraform {
  required_providers {
    akeyless = {
      version = ">= 1.0.0"
      source  = "akeyless-community/akeyless"
    }
  }
}

provider "akeyless" {
  aws_iam_login {
    access_id = var.akeyless_aws_iam_access_id
  }
}

resource "akeyless_auth_method_oauth2" "github" {
  count             = length(var.repository_access) > 0 ? 1 : 0
  name              = var.github_auth_name
  jwks_uri          = "https://token.actions.githubusercontent.com/.well-known/jwks"
  unique_identifier = var.unique_identifier
  force_sub_claims  = true
}


resource "akeyless_associate_role_auth_method" "gateway_role_attachment" {
  for_each = { for index, access in var.repository_access : index => access }

  am_name    = trimprefix(akeyless_auth_method_oauth2.github[0].name, "/")
  role_name  = trimprefix(each.value.role_name, "/")
  sub_claims = each.value.sub_claims
}
