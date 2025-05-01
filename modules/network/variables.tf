variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

# variable "aks_subnet_name" {
#   type = string
# }

variable "vnet_address_space" {
  type = list(string)
}

variable "subnets" {
  type = list(object({
    name   = string
    prefix = string
  }))
}
