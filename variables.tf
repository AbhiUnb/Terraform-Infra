variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region to deploy the resources"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the virtual machine"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to the public SSH key file"
}

variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}