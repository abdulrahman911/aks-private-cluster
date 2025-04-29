output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "aks_subnet_id" {
  value = azurerm_subnet.aks.id
}

output "jumpbox_subnet_id" {
  value = azurerm_subnet.jumpbox.id
}

output "bastion_subnet_id" {
  value = azurerm_subnet.bastion.id
}

output "resource_group_name" {
  value = azurerm_resource_group.network.name
}

output "location" {
  value = azurerm_resource_group.network.location
}
