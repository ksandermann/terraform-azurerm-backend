variable "backend_resource_group_name" {
  type        = string
  description = "Name of the resource group the storage account should be placed in. Needs to be created outside of this module."
}

variable "backend_resource_tags" {
  type        = map(string)
  description = "Tags to add to the storage account and storage container resources."
  default = {
    "content"    = "terraform statefiles"
    "persistent" = "true"
  }
}

variable "backend_storage_account_name" {
  type        = string
  description = "Name of the storage account. Will be transformed to a valid format using local regex."
}

variable "backend_storage_account_tier" {
  type        = string
  description = "Tier of the storage account"
  default     = "Standard"
}

variable "backend_storage_account_replication_type" {
  type        = string
  description = "Replication type of the storage account"
  default     = "LRS"
}

variable "backend_storage_container_name" {
  type        = string
  description = "Name of the storage container. Will be transformed to a valid format using local regex."
}

locals {
  //name can only consist of lowercase letters and numbers, and must be between 3 and 24 characters long
  //1. take backend_storage_account_name
  //2. make all letters lowercase
  //3. remove everything but lowercase letters and numbers
  //4. trim to 24 characters
  sa_name = substr(replace(lower(var.backend_storage_account_name), "/[^0-9a-z]*/", ""), 0, 24)

  //only lowercase alphanumeric characters and hyphens allowed in "name":
  //1. take backend_storage_container_name
  //2. make all letters lowercase
  //3. replace all chars that are not alphanumeric with hyphens
  //5. trim to 48 characters
  //6. remove potential trailing hyphen
  sc_name = replace(substr(replace(lower(var.backend_storage_container_name), "/[^0-9a-z]/", "-"), 0, 48), "/(.*)-$/", "$1")
}
