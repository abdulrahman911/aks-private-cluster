remote_state {
  backend = "azurerm"
  config = {
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    resource_group_name  = get_env("TF_VAR_REMOTE_STATE_RG", "")
    storage_account_name = get_env("TF_VAR_REMOTE_STATE_STORAGE_ACCOUNT", "")
    container_name       = get_env("TF_VAR_REMOTE_STATE_CONTAINER", "")
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}
