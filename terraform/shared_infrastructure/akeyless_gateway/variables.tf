variable "name" {
  type        = string
  description = "The name of the infrastructure"
}

################
## Networking ##
################
variable "vpc_id" {
  type        = string
  description = "The ID of the VPC that the gateway will live in"
}

variable "public_subnet_ids" {
  type        = list(any)
  description = "A list of the public subnet ids to put the load balancer in"
}

variable "private_subnet_ids" {
  type        = list(any)
  description = "A list of the private subnet ids to put the ECS tasks in"
}

#########
## DNS ##
#########
variable "route_53_hosted_zone_name" {
  type        = string
  description = "The name of the Route53 hosted zone that the gateway domain will belong to"
}

variable "domain_name" {
  type        = string
  description = "The name of the domain to host the gateway on"
}

#############
## Gateway ##
#############
variable "iam_role_arn" {
  type        = string
  description = "The ARN of the IAM role to attach to the gateway.  Should correspond to the bound ARN of the admin access id"
}

variable "admin_access_id" {
  type        = string
  description = "The access id that the AKeyless Gateway will use for admin access (see https://docs.akeyless.io/docs/install-and-configure-the-gateway)"
}

variable "allowed_access_ids" {
  type        = string
  description = "The access ids that can be used to configure the AKeyless Gateway (see https://docs.akeyless.io/docs/install-and-configure-the-gateway)"
}

##########
## Misc ##
##########
variable "alb_access_logs_bucket_name" {
  type        = string
  description = "The name of the S3 bucket to store access logs for the ALB in"
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all relevant pieces of infrastructure"
}
