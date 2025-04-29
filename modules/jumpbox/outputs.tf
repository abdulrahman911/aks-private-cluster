output "jumpbox_private_ip" {
  description = "Private IP address of Jumpbox VM"
  value       = azurerm_network_interface.jumpbox_nic.private_ip_address
}

output "jumpbox_vm_id" {
  description = "ID of the Jumpbox Virtual Machine"
  value       = azurerm_linux_virtual_machine.jumpbox.id
}
