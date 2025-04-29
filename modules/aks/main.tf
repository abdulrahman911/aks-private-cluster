# Configure the Azure Provider
provider "azurerm" {
  features {}
}

# Create the Azure Kubernetes Service (AKS) cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                      = var.name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  dns_prefix                = var.dns_prefix
  kubernetes_version        = var.kubernetes_version
  private_cluster_enabled   = var.private_cluster_enabled
  oidc_issuer_enabled       = var.oidc_issuer_enabled
  workload_identity_enabled = var.workload_identity_enabled

  # Configure the default (system) node pool
  default_node_pool {
    name                 = var.system_node_pool_name
    node_count           = var.system_node_pool_node_count
    vm_size              = var.system_node_pool_vm_size
    vnet_subnet_id       = var.subnet_id
    os_disk_size_gb      = var.system_node_os_disk_size_gb
    auto_scaling_enabled = var.auto_scaling_enabled
    min_count            = var.system_node_min_count
    max_count            = var.system_node_max_count
    type                 = var.type
  }

  # Enable managed identity for the AKS cluster
  identity {
    type = var.identity_type
  }

  # Configure the AKS network settings
  network_profile {
    network_plugin    = var.network_plugin
    load_balancer_sku = var.load_balancer_sku
    service_cidr      = var.service_cidr[0]   # CIDR block for internal services
    dns_service_ip    = var.dns_service_ip[0] # DNS IP address for the service CIDR
  }

  # Enable role-based access control (RBAC)
  role_based_access_control_enabled = var.role_based_access_control_enabled

  # Configure Azure Active Directory integration for AKS
  azure_active_directory_role_based_access_control {
    tenant_id              = var.tenant_id
    admin_group_object_ids = var.admin_group_object_ids
    azure_rbac_enabled     = var.azure_rbac_enabled
  }

  # Specify the Private DNS zone ID (for private cluster)
  private_dns_zone_id = var.private_dns_zone_id

  # Apply tags to the AKS cluster
  tags = var.tags
}

# Create an additional user node pool for AKS
resource "azurerm_kubernetes_cluster_node_pool" "user_node_pools" {
  name                  = var.user_node_pool_name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.user_node_pool_vm_size
  vnet_subnet_id        = var.subnet_id
  os_disk_size_gb       = var.user_node_pool_os_disk_size_gb
  auto_scaling_enabled  = var.auto_scaling_enabled
  min_count             = var.user_node_pool_min_count
  max_count             = var.user_node_pool_max_count
  mode                  = var.user_mode
  orchestrator_version  = var.kubernetes_version
  node_labels           = var.user_node_pool_node_labels
}
