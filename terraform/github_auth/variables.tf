variable "github_auth_name" {
  type        = string
  description = "The name of the Github auth method to create"
  default     = "/shared/github"
}

variable "unique_identifier" {
  type        = string
  description = "The unique identifier to use on the github auth method"
  default     = "repository"
}

variable "akeyless_aws_iam_access_id" {
  type        = string
  description = "The access id that terraform should use to login to AKeyless (expects AWS IAM auth)"
}

variable "repository_access" {
  type        = list(any)
  description = "The repository access list"
}
