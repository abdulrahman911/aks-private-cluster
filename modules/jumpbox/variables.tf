variable "resource_group_name" {
  description = "Name of the Resource Group for the Jumpbox VM"
  type        = string
}

variable "location" {
  description = "Azure region to deploy resources into"
  type        = string
}

variable "vm_name" {
  description = "Name of the Jumpbox VM"
  type        = string
}

variable "vm_size" {
  description = "Size of the Jumpbox VM"
  type        = string
  default     = "Standard_B1ms"
}

variable "admin_username" {
  description = "Admin username for SSH login"
  type        = string
}

variable "admin_password" {
  description = "Password for the admin user"
  type        = string
}

variable "jumpbox_subnet_id" {
  description = "Subnet ID where the Jumpbox VM will be deployed"
  type        = string
}

variable "image_publisher" {
  description = "Image publisher"
  type        = string
}

variable "image_offer" {
  description = "Image offer"
  type        = string
}

variable "image_sku" {
  description = "Image SKU"
  type        = string
}

variable "image_version" {
  description = "Image version"
  type        = string
  default     = "latest"
}

variable "os_disk_type" {
  description = "The type of storage account for the OS Disk"
  type        = string
  default     = "Standard_LRS"
}

variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default     = {}
}

variable "jumpbox_ip_configuration" {
  type = string
}

variable "private_ip_address_allocation" {
  type = string
}

variable "os_disk_caching" {
  type = string
}

variable "disable_password_authentication" {
  type = bool
}