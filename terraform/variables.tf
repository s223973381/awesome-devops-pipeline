variable "env" {}
variable "image_name" {}
variable "acr_login_server" {}
variable "acr_username" {}
variable "acr_password" {}
variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "image_tag" {
  description = "The Docker image tag to deploy (commit SHA or staging/production)"
  type        = string
}
