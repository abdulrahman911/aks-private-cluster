# Include the root terragrunt configuration
include {
  path = find_in_parent_folders("root.hcl")
}

locals {
    environment = "production"
}

# Configure terraform source network module
terraform {
  source = "../../../modules/network"
}

# Input variables for the Network module
inputs = {
  location               = "UAE North"
  resource_group_name    = "${local.environment}-rg-infra"
  vnet_name              = "${local.environment}-vnet"
  vnet_address_space     = ["10.10.0.0/16"]
  aks_subnet_prefixes    = ["10.10.1.0/24"]
  jumpbox_subnet_prefixes = ["10.10.2.0/24"]
  bastion_subnet_prefixes = ["10.10.3.0/27"]
  aks_subnet_name         = "${local.environment}-aks-subnet"
  bastion_subnet_name      = "AzureBastionSubnet"
  jumpbox_subnet_name      = "${local.environment}-jumpbox-subnet"

}
