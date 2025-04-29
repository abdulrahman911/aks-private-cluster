variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "dns_prefix" {}
variable "kubernetes_version" {}

variable "subnet_id" {}
variable "private_dns_zone_id" {}

variable "system_node_pool_name" {}
variable "system_node_pool_node_count" {}
variable "system_node_pool_vm_size" {}
variable "system_node_os_disk_size_gb" {}
variable "system_node_min_count" {}
variable "system_node_max_count" {}
variable "type" {}
variable "auto_scaling_enabled" {
  type    = bool
  default = true
}

variable "user_node_pool_name" {
  type        = string
  description = "Name of the user node pool"
}

variable "user_node_pool_vm_size" {
  type        = string
  description = "VM size for the user node pool"
}

variable "user_node_pool_os_disk_size_gb" {
  type        = number
  description = "OS Disk size for the user node pool"
}

variable "user_node_pool_auto_scaling_enabled" {
  type        = bool
  description = "Whether autoscaling is enabled for the user node pool"
}

variable "user_node_pool_min_count" {
  type        = number
  description = "Minimum node count for autoscaling"
}

variable "user_node_pool_max_count" {
  type        = number
  description = "Maximum node count for autoscaling"
}

variable "user_node_pool_node_labels" {
  type        = map(string)
  description = "Node labels for the user node pool"
}

variable "tenant_id" {}
variable "admin_group_object_ids" {
  type = list(string)
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "private_cluster_enabled" {
  type = bool
}

variable "oidc_issuer_enabled" {
  type = bool
}

variable "workload_identity_enabled" {
  type = bool
}

variable "identity_type" {
  type = string
}

variable "network_plugin" {
  type = string
}

variable "load_balancer_sku" {
  type = string
}

variable "service_cidr" {
  type = list(string)
}

variable "dns_service_ip" {
  type = list(string)
}

variable "role_based_access_control_enabled" {
  type = bool
}

variable "azure_rbac_enabled" {
  type = bool
}

variable "user_mode" {
  type = string
}