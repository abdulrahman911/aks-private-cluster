include {
  path = find_in_parent_folders()
}

locals {
    environment = "production"
}

terraform {
  source = "../../../modules/network"
}

inputs = {
  location               = "UAE North"
  resource_group_name    = "${local.environment}-rg-infra"
  vnet_name              = "${local.environment}-vnet"
  vnet_address_space     = ["10.0.0.0/16"]
  aks_subnet_prefixes    = ["10.0.1.0/24"]
  jumpbox_subnet_prefixes = ["10.0.2.0/24"]
  bastion_subnet_prefixes = ["10.0.3.0/27"]
  aks_subnet_name         = "${local.environment}-aks-subnet"
  bastion_subnet_name      = "AzureBastionSubnet"
  jumpbox_subnet_name      = "${local.environment}-jumpbox-subnet"

}
