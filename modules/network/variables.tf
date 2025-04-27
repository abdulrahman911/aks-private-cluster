variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "aks_subnet_name" {
  type = string
}

variable "jumpbox_subnet_name" {
  type = string
}

variable "bastion_subnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "aks_subnet_prefixes" {
  type = list(string)
}

variable "jumpbox_subnet_prefixes" {
  type = list(string)
}

variable "bastion_subnet_prefixes" {
  type = list(string)
}
