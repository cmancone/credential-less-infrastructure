variable "name" {
  type        = string
  description = "The name for the VPC"
}

variable "availability_zone_names" {
  type        = list(string)
  description = "List of availability zone names to put the VPC in"
}

variable "vpc_flow_log_bucket_name" {
  type        = string
  description = "Name for an S3 bucket to send VPC flow logs to (the bucket itself is not created automatically)"
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "Tags to attach to all resources"
}
