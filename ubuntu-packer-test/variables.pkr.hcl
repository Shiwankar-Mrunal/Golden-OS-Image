// -------------------
// Variables for Azure Ubuntu Packer Build
// -------------------

# variable "client_id" {
#   type = string
# }

# variable "client_secret" {
#   type      = string
#   sensitive = true
# }

# variable "tenant_id" {
#   type = string
# }

# variable "subscription_id" {
#   type = string
# }

variable "resource_group_name" {
  type    = string
  default = "M-ResourceGroup"
}

variable "location" {
  type    = string
  default = "West Europe"
}

variable "vm_size" {
  type    = string
  default = "Standard_B2s"
}

variable "image_publisher" {
  type    = string
  default = "Canonical"
}

variable "image_offer" {
  type    = string
  default = "0001-com-ubuntu-server-jammy"
}

variable "image_sku" {
  type    = string
  default = "22_04-lts-gen2"
}

variable "image_version" {
  type    = string
  default = "latest"
}
