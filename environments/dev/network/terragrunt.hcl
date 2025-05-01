# Include the root terragrunt configuration
include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  environment = local.env_vars.locals.environment
  location  = local.env_vars.locals.location
}  

# Configure terraform source network module
terraform {
  source = "../../../modules/network"
}

# Input variables for the Network module
inputs = {
  location               = local.location #"UAE North"
  resource_group_name    = "${local.environment}-rg-infra"
  vnet_name              = "${local.environment}-vnet"
  vnet_address_space     = ["10.0.0.0/16"]

  subnets = [
    {
      name   = "${local.environment}-aks-subnet"
      prefix = "10.0.1.0/24"
    },
    {
      name   = "${local.environment}-jumpbox-subnet"
      prefix = "10.0.2.0/24"
    },
    {
      name   = "AzureBastionSubnet"
      prefix = "10.0.3.0/27"
    }
    # Add more subnets here
  ]
}