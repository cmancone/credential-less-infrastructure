provider "akeyless" {
  alias = "global-cloud"

  aws_iam_login {
    access_id = var.akeyless_aws_iam_access_id
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

  am_name   = trimprefix("${var.akeyless_folder}/${var.name}", "/")
  role_name = trimprefix(var.akeyless_gateway_akeyless_role_name, "/")

  depends_on = [akeyless_auth_method_aws_iam.gateway_auth]
}

###
### These will only work after our Gateway exists
###
/*
provider "akeyless" {
  alias               = "gateway"
  api_gateway_address = "https://${var.akeyless_gateway_domain_name}:8081"

  aws_iam_login {
    access_id = var.akeyless_aws_iam_access_id
  }
}

# Create an IAM user that will be used by our AWS Target
resource "aws_iam_user" "assume-admin" {
  name = "${var.name}-gateway-assume-admin"
  force_destroy = true

  tags = merge(var.tags, {
    Name = "${var.name}-gateway-assumed-admin"
  })
}

resource "aws_iam_access_key" "assume-admin" {
  user = aws_iam_user.assume-admin.name

  lifecycle {
    ignore_changes = all
  }
}

# we need permission to assume the admin role
resource "aws_iam_user_policy" "assume-admin" {
  name = "assume-admin"
  user = aws_iam_user.assume-admin.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Resource": "*"
        }
    ]
}
EOF
}

# and we also want permission to manage users (just in case)
# Also, grant our user permission to change their own password
resource "aws_iam_user_policy" "user-management" {
  name = "user-management"
  user = aws_iam_user.assume-admin.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "TemporaryUsers",
      "Effect": "Allow",
      "Action": [
        "iam:DeleteAccessKey",
        "iam:AttachUserPolicy",
        "iam:DeleteUser",
        "iam:ListUserPolicies",
        "iam:CreateUser",
        "iam:TagUser",
        "iam:CreateAccessKey",
        "iam:ListGroupsForUser",
        "iam:ListAttachedUserPolicies",
        "iam:DetachUserPolicy",
        "iam:ListUserTags",
       "iam:ListAccessKeys"
      ],
      "Resource": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/tmp*"
    },
    {
      "Sid": "GroupManagement",
      "Effect": "Allow",
      "Action": [
        "iam:AddUserToGroup",
        "iam:RemoveUserFromGroup"
      ],
      "Resource": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:group/*"
    },
    {
        "Sid": "ListUsers",
        "Effect": "Allow",
        "Action": [
            "iam:ListUsers",
            "iam:ListGroups"
        ],
        "Resource": "*"
    },
    {
      "Sid": "AccessKeyRotation",
      "Effect": "Allow",
     "Action": [
        "iam:ListAccessKeys",
        "iam:CreateAccessKey",
        "iam:DeleteAccessKey",
        "iam:GetUser",
        "iam:ListUserTags"
      ],
      "Resource": [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/$${aws:username}"
      ]
    }
  ]
}
EOF
}

# add an AWS target pointing at the Gateways IAM credentials
resource "akeyless_target_aws" "target_aws" {
  provider = akeyless.gateway

  # For first deployment
  access_key_id         = aws_iam_access_key.assume-admin.id
  access_key            = aws_iam_access_key.assume-admin.secret

  # After first deployment
  # access_key_id         = ""
  # access_key            = ""

  name                  = "${var.akeyless_folder}/${var.name}-aws"
  region                = var.region
  key                   = ""

  depends_on = [akeyless_auth_method_aws_iam.gateway_auth, module.gateway-ecs]

  # Some of our AKeyless resources are hard for terraform to update because
  # credentials are no longer managed by terraform after the initial creation.
  # Therefore, we don't want to update them in the future.
  lifecycle {
    ignore_changes = all
  }
}

resource "akeyless_rotated_secret" "aws_rotator" {
  provider = akeyless.gateway

  name = "${var.akeyless_folder}/${var.name}-aws-rotator"
  rotator_type = "target"
  target_name = trimprefix(akeyless_target_aws.target_aws.name, "/")
  rotation_interval = "1"
  authentication_credentials = "use-target-creds"

  # Some of our AKeyless resources are hard for terraform to update because
  # credentials are no longer managed by terraform after the initial creation.
  # Therefore, we don't want to update them in the future.
  lifecycle {
    ignore_changes = all
  }
}

# add an AWS producer to generate admin credentials
resource "akeyless_producer_aws" "admin" {
  provider = akeyless.gateway

  name                         = "${var.akeyless_folder}/aws-admin"
  access_mode                  = "assume_role"
  target_name                  = trimprefix(akeyless_target_aws.target_aws.name, "/")
  region                       = var.region
  aws_role_arns                = var.aws_role_arn_for_producer
  aws_user_programmatic_access = true

  # we don't want to try to create the producer until the rotator exists,
  # because the rotator will muck with the credentials, and I don't want to have
  # to worry about this causing issues with the producer when it is created
  depends_on = [module.gateway-ecs, akeyless_rotated_secret.aws_rotator]
}
*/
