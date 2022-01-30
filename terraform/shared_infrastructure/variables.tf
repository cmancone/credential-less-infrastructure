variable "name" {
  type        = string
  description = "The name for this shared infrastructure"
}

variable "availability_zone_names" {
  type        = list(string)
  description = "List of availability zone names to put the VPC in"
}

variable "tags" {
  type        = map(string)
  description = "Tags to attach to all resources"
}
