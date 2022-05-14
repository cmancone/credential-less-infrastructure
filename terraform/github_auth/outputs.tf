output "github_access_id" {
  value       = length(var.repository_access) > 0 ? akeyless_auth_method_oauth2.github[0].access_id : ""
  description = "The Access ID of the OAuth2 method to be used by Github Actions"
}
