# Include the root configuration
include {
  path = find_in_parent_folders("root.hcl")
}

# Set local values for this configuration
locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  environment = local.env_vars.locals.environment
  location  = local.env_vars.locals.location
}  

# Define dependency on the network module
dependency "network" {
  config_path = "../network"
  
  # Mock outputs for planning without applying
  mock_outputs = {
    aks_subnet_id       = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mock-rg/providers/Microsoft.Network/virtualNetworks/mock-vnet/subnets/mock-subnet-id-aks"
    resource_group_name = "dev-rg-infra"
  }
  mock_outputs_allowed_terraform_commands = ["init", "plan"]
}

# Define the module source path
terraform {
  source = "../../../modules/aks"
}

# Ensure network dependency is applied first
dependencies {
  paths = [
    "../network"
  ]
}

# Inputs for the AKS cluster module
inputs = {
  name                    = "${local.environment}-aks-cluster"
  location                = dependency.network.outputs.location
  resource_group_name     = dependency.network.outputs.resource_group_name
  dns_prefix              = "${local.environment}-aks"
  kubernetes_version      = "1.31.7"

  subnet_id               = dependency.network.outputs.aks_subnet_id
  private_dns_zone_id     = "System" 
  
  # Cluster settings
  private_cluster_enabled   = true
  oidc_issuer_enabled       = true
  workload_identity_enabled = true
  azure_rbac_enabled     = true
  role_based_access_control_enabled = true
  identity_type             = "SystemAssigned"
  network_plugin    = "azure"
  load_balancer_sku = "standard"
  service_cidr      = ["10.99.0.0/16"]
  dns_service_ip    = ["10.99.0.10"]
  user_mode         = "User"
  
  # Azure AD integration
  tenant_id               = get_env("AZURE_TENANT_ID")
  admin_group_object_ids  = split(",", get_env("AZURE_ADMIN_GROUP_OBJECT_IDS"))

  auto_scaling_enabled    = true

  # System Node Pool
  system_node_pool_name         = "systempool"
  system_node_pool_node_count   = 1
  system_node_pool_vm_size      = "Standard_DS2_v2"
  system_node_os_disk_size_gb   = 128
  system_node_min_count         = 1
  system_node_max_count         = 3
  type                          = "VirtualMachineScaleSets"

  # User Node Pool 
  user_node_pool_name              = "userpool1"
  user_node_pool_vm_size           = "Standard_DS2_v2"
  user_node_pool_os_disk_size_gb   = 128
  user_node_pool_auto_scaling_enabled = true
  user_node_pool_min_count         = 1
  user_node_pool_max_count         = 5
  user_node_pool_node_labels       = {
    "role" = "user"  
  }
  
  # Add environment tags
  tags = {
    Environment = local.environment
    Project     = "aks"
  }
}
