variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "bastion_name" {
  type = string
}

variable "bastion_subnet_id" {
  type = string
}

variable "public_ip_sku" {
  type        = string
  description = "SKU for the Public IP Address (must be 'Standard' for Bastion)"
}

variable "allocation_method" {
  type = string
}

variable "sku_tier" {
  type = string
}

variable "ip_configuration" {
  type = string
}