# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a Resource Group for network resources
resource "azurerm_resource_group" "network" {
  name     = var.resource_group_name
  location = var.location
}

# Create a Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.network.name
}

# Create a Subnet for AKS (Azure Kubernetes Service)
resource "azurerm_subnet" "aks" {
  name                 = var.aks_subnet_name
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.aks_subnet_prefixes
}

# Create a Subnet for Jumpbox (for admin access)
resource "azurerm_subnet" "jumpbox" {
  name                 = var.jumpbox_subnet_name
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.jumpbox_subnet_prefixes
}

# Create a Subnet for Azure Bastion (for secure VM access)
resource "azurerm_subnet" "bastion" {
  name                 = var.bastion_subnet_name
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.bastion_subnet_prefixes
}

