# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a Public IP Address for Bastion Host
resource "azurerm_public_ip" "bastion_ip" {
  name                = "${var.bastion_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method
  sku                 = var.public_ip_sku
  sku_tier            = var.sku_tier
}

# Create a Bastion Host for secure VM access over the Azure portal
resource "azurerm_bastion_host" "bastion" {
  name                = var.bastion_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = var.ip_configuration
    subnet_id            = var.bastion_subnet_id
    public_ip_address_id = azurerm_public_ip.bastion_ip.id
  }
}
