# Include the root terragrunt configuration
include {
  path = find_in_parent_folders("root.hcl")
}

# Set local values for this configuration
locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  environment = local.env_vars.locals.environment
  location  = local.env_vars.locals.location
} 

# Define a dependency on the 'network' configuration
dependency "network" {
  config_path = "../network"

  mock_outputs = {
    bastion_subnet_id = "mock-subnet-id"
    resource_group_name = "production-rg-infra"
  }
  mock_outputs_allowed_terraform_commands = ["init", "plan"]
}

# Configure Terraform source module
terraform {
  source = "../../../modules/bastion"
}

# Ensure 'network' dependency is applied before this configuration
dependencies {
  paths = ["../network"]
}

# Input variables for the Bastion module
inputs = {
  location           = local.location
  resource_group_name= dependency.network.outputs.resource_group_name
  bastion_name       = "${local.environment}-bastion"
  bastion_subnet_id  = dependency.network.outputs.bastion_subnet_id
  public_ip_sku       = "Standard"
  allocation_method   = "Static"
  sku_tier            = "Regional"
  ip_configuration     = "configuration"
}
