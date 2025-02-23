variable "azure_subscription_id" {
  description = "Azure subscription ID for the resources"
  nullable    = false
  type        = string
}

variable "azure_location" {
  default     = "Sweden Central"
  description = "Azure location name for the resources"
  nullable    = false
  type        = string
}

variable "project_name" {
  description = "Project name for prefix resources"
  nullable    = false
  type        = string
}

variable "instances" {
  description = "List of instances to create"
  nullable    = false
  type        = list(string)
}

variable "vm_admin_password_suffix" {
  description = "Suffix part of the VM admin password (prefix is instance)"
  nullable    = false
  type        = string
}

variable "vm_sku" {
  default     = "Standard_B2s"
  description = "VM size SKU (B2s has 2 vCPUs and 4 GiB of memory)"
  nullable    = false
  type        = string
}

variable "vm_allowed_ssh_ips" {
  description = "List of IPs allowed for SSH access"
  nullable    = false
  type        = list(string)
}
