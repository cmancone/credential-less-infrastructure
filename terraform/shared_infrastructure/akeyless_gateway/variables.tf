variable "name" {
  type        = string
  description = "The name of the infrastructure"

  validation {
    condition     = length(var.name) > 32
    error_message = "The name must be 32 characters or less to comply with ALB naming requirements."
  }

  validation {
    condition     = can(regex("^[0-9A-Za-z-]+$", var.name))
    error_message = "The name can only contain letters, numbers, and hyphens in order to comply with ALB naming requirements."
  }
}

################
## Networking ##
################
variable "vpc_id" {
  type        = string
  description = "The ID of the VPC that the gateway will live in"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "A list of the public subnet ids to put the load balancer in"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "A list of the private subnet ids to put the ECS tasks in"
}

variable "gateway_ports" {
  type        = map(number)
  description = "A map for port mapping.  The key tells what port to open on the ALB and the value is which port to route it to on the gateway."
  default     = { 8000 : 8000, 18888 : 18888, 8200 : 8200, 8080 : 8080, 5696 : 5696 }
}

variable "security_group_allowed_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks to whitelist incoming traffic from in the security group"
  default     = ["0.0.0.0/0"]
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
variable "desired_task_count" {
  type        = number
  description = "The desired number of ECS tasks to run for the gateway"
  default     = 1
}

variable "alb_access_logs_bucket_name" {
  type        = string
  description = "The name of the S3 bucket to store access logs for the ALB in"
  default     = ""
}

variable "ssl_policy" {
  type        = string
  description = "The AWS SSL policy to use"
  default     = "ELBSecurityPolicy-TLS-1-2-2017-01"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all relevant pieces of infrastructure"
}
