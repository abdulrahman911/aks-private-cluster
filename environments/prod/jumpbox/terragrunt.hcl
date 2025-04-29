# Include the root Terragrunt configuration 
include {
  path = find_in_parent_folders("root.hcl")
}

# Define dependency on the network module
dependency "network" {
  config_path = "../network"
  
  # Mock outputs are used during init/plan when the dependency is not applied yet
  mock_outputs = {
    jumpbox_subnet_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mock-rg/providers/Microsoft.Network/virtualNetworks/mock-vnet/subnets/mock-subnet"
    resource_group_name = "production-rg-infra"
    location = "UAE North" 
  }
  mock_outputs_allowed_terraform_commands = ["init", "plan"]
}

# Define local variables
locals {
    environment = "production"
}

# Define the source module path to use for the jumpbox resources
terraform {
  source = "../../../modules/jumpbox"
}

# Ensure the network module is applied first before this module
dependencies {
  paths = ["../network"]
}

# Input variables to pass to the jumpbox module
inputs = {
  location            = dependency.network.outputs.location
  resource_group_name = dependency.network.outputs.resource_group_name
  vm_name             = "${local.environment}-jumpbox-vm"
  vm_size             = "Standard_B1ms"
   
  jumpbox_ip_configuration = "internal"

  admin_username      = get_env("TF_VAR_admin_username")
  admin_password      = get_env("TF_VAR_admin_password")

  jumpbox_subnet_id   = dependency.network.outputs.jumpbox_subnet_id
  private_ip_address_allocation = "Dynamic"
  os_disk_caching = "ReadWrite"
  disable_password_authentication = false
  
  # Define image details for the jumpbox VM
  image_publisher     = "Canonical"
  image_offer         = "0001-com-ubuntu-server-jammy"
  image_sku           = "22_04-lts-gen2"
  image_version       = "latest"
  
  # Define disk type
  os_disk_type        = "Standard_LRS"
  
  # Add tags for resource tracking
  tags = {
    environment = local.environment
    owner       = "DevOps-Team"
  }
}