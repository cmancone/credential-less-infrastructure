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

variable "vpc_id" {
  type        = string
  description = "The id of the VPC that the resources will live in"
}

variable "load_balancer_arn" {
  type        = string
  description = "The ARN of the load balancer"
}

variable "internet_port" {
  type        = number
  description = "The internet-facing port to open to incoming traffic"
}

variable "container_port" {
  type        = number
  description = "The container-facing port to map the incoming traffic to"
}

variable "certificate_arn" {
  type        = string
  description = "The ARN of the ACM certificate to associate with the listener"
}

variable "lb_security_group_id" {
  type        = string
  description = "The ID of the security group used by the load balancer"
}

variable "ecs_tasks_security_group_id" {
  type        = string
  description = "The ID of the security group used by the ECS tasks"
}

variable "security_group_allowed_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks to whitelist incoming traffic from in the security group"
  default     = ["0.0.0.0/0"]
}

variable "ssl_policy" {
  type        = string
  description = "The AWS SSL policy to use"
  default     = "ELBSecurityPolicy-TLS-1-2-2017-01"
}
