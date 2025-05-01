output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "aks_subnet_id" {
  value = azurerm_subnet.subnets["dev-aks-subnet"].id
}

output "jumpbox_subnet_id" {
  value = azurerm_subnet.subnets["dev-jumpbox-subnet"].id
}

output "bastion_subnet_id" {
  value = azurerm_subnet.subnets["AzureBastionSubnet"].id
}

output "resource_group_name" {
  value = azurerm_resource_group.network.name
}

output "location" {
  value = azurerm_resource_group.network.location
}
