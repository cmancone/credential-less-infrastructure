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

variable "region" {
  type        = string
  description = "The region that the infrastructure is destined for"
}

variable "vpc_id" {
  type        = string
  description = "The region that the infrastructure is destined for"
}

variable "route_53_hosted_zone_name" {
  type        = string
  description = "The name of the Route53 hosted zone that the gateway domain will belong to"
}

variable "domain_name" {
  type        = string
  description = "The name of the domain to host the gateway on"
}

variable "iam_role_name" {
  type        = string
  description = "The name of the IAM role to create and attach to the gateway."
}

variable "admin_access_id" {
  type = string
}

variable "allowed_access_ids" {
  type        = string
  description = "The access ids that can be used to configure the AKeyless Gateway (see https://docs.akeyless.io/docs/install-and-configure-the-gateway)"
}

variable "subnet_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "gateway_ports" {
  type        = map(number)
  description = "A map for port mapping.  The key tells what port to open on the ALB and the value is which port to route it to on the gateway."
  default     = { 8000 : 8000, 18888 : 18888, 8200 : 8200, 8080 : 8080, 8081 : 8081, 5696 : 5696 }
}

variable "tags" {
  type        = map(string)
  description = "Tags to attach to all resources"
  default     = {}
}
