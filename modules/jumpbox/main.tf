# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a Network Interface for the Jumpbox VM
resource "azurerm_network_interface" "jumpbox_nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name


  ip_configuration {
    name                          = var.jumpbox_ip_configuration
    subnet_id                     = var.jumpbox_subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
  }
}

# Create a Linux Virtual Machine for the Jumpbox
resource "azurerm_linux_virtual_machine" "jumpbox" {
  name                  = var.vm_name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.jumpbox_nic.id]

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_type
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  disable_password_authentication = var.disable_password_authentication

  tags = var.tags
}
