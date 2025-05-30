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

# Create Subnets dynamically
resource "azurerm_subnet" "subnets" {
  for_each = {
    for subnet in var.subnets : subnet.name => subnet
  }

  name                 = each.value.name
  address_prefixes     = [each.value.prefix]
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}
