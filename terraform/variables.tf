variable "name" {
  type        = string
  description = "The name for this shared infrastructure"

  validation {
    condition     = length(var.name) <= 32
    error_message = "The name must be 32 characters or less to comply with ALB naming requirements."
  }

  validation {
    condition     = can(regex("^[0-9A-Za-z-]+$", var.name))
    error_message = "The name can only contain letters, numbers, and hyphens in order to comply with ALB naming requirements."
  }
}

variable "aws_role_arn_for_producer" {
  type        = string
  description = "The ARN for the AWS role that the gateway will generate temporary credentials for."
}

variable "akeyless_aws_iam_access_id" {
  type        = string
  description = "The access id that terraform should use to login to AKeyless (expects AWS IAM auth)"
}

variable "akeyless_folder" {
  type        = string
  description = "The folder where all of our AKeyless resources will live."
}

variable "akeyless_gateway_akeyless_role_name" {
  type        = string
  description = "The name of the role in AKeyless to grant the gateway access to"
}

variable "akeyless_gateway_admin_access_key" {
  type        = string
  description = "The access key that the gateway will use to authenticate itself to AKeyless.  Use if 'admin_access_id' corresponds to an API key"
  default     = ""
}

variable "akeyless_gateway_admin_password" {
  type        = string
  description = "Password, relevant only when using an email address as your authentication method (which I don't recommend)."
  default     = ""
}

variable "akeyless_gateway_allowed_access_ids" {
  type        = string
  description = "The access ids that can be used to configure the AKeyless Gateway (see https://docs.akeyless.io/docs/install-and-configure-the-gateway)"
}

variable "akeyless_gateway_desired_task_count" {
  type        = number
  description = "The desired number of ECS tasks to run for the gateway"
  default     = 1
}

variable "route_53_hosted_zone_name" {
  type        = string
  description = "The name of the Route53 hosted zone that the gateway domain will belong to"
}

variable "primary_region" {
  type        = string
  description = "The AWS region to use for the 'primary' cluster deployment"
}

variable "primary_region_domain_name" {
  type        = string
  description = "The name of the domain to host the gateway on in the 'primary' region"
}

variable "primary_region_availability_zone_names" {
  type        = list(string)
  description = "List of availability zone names to use in the 'primary' region"
}

# variable "secondary_region" {
#   type        = string
#   description = "The AWS region to use for the 'secondary' cluster deployment"
# }
#
# variable "secondary_region_domain_name" {
#   type        = string
#   description = "The name of the domain to host the gateway on in the 'secondary' region"
# }
#
# variable "secondary_region_availability_zone_names" {
#   type        = list(string)
#   description = "List of availability zone names to use in the 'secondary' region"
# }

variable "vpc_flow_log_bucket_name" {
  type        = string
  description = "Name of an S3 bucket to store VPC flow logs in"
  default     = ""
}

variable "alb_access_logs_bucket_name" {
  type        = string
  description = "The name of the S3 bucket to store access logs for the ALB in"
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "Tags to attach to all resources"
  default     = {}
}

variable "repository_access" {
  type        = list(any)
  description = "The repository access list"
}
