

// Main Packer template for Azure Ubuntu image

packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 2"
    }
  }
}

# -------------------
# Variables
# -------------------
variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
  sensitive = true
}

variable "tenant_id" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "resource_group_name" {
  type    = string
  default = "M-ResourceGroup"   # <-- Must exist in your Azure subscription
}

variable "location" {
  type    = string
  default = "West Europe"
}

variable "vm_size" {
  type    = string
  default = "Standard_B1s"
}

variable "image_publisher" {
  type    = string
  default = "Canonical"
}

variable "image_offer" {
  type    = string
  default = "UbuntuServer"
}

variable "image_sku" {
  type    = string
  default = "18.04-LTS"
}

variable "image_version" {
  type    = string
  default = "latest"
}

# -------------------
# Azure ARM builder
# -------------------
source "azure-arm" "ubuntu" {
  client_id          = var.client_id
  client_secret      = var.client_secret
  tenant_id          = var.tenant_id
  subscription_id    = var.subscription_id

  managed_image_resource_group_name = var.resource_group_name
  managed_image_name = "ubuntu-${var.image_sku}-${formatdate("DDMMMYYYY", timestamp())}"





  os_type          = "Linux"
  image_publisher  = var.image_publisher
  image_offer      = var.image_offer
  image_sku        = var.image_sku
  image_version    = var.image_version

  location         = var.location
  vm_size          = var.vm_size

  # Temporary resource group created & deleted automatically by Packer
  temp_resource_group_name = "${var.resource_group_name}-temp-rg"
}

# -------------------
# Build definition
# -------------------
build {
  name    = "ubuntu-image-build"
  sources = ["source.azure-arm.ubuntu"]

  # Provisioner runs setup.sh which installs packages, hardens security, and tunes performance
  provisioner "shell" {
    script = "scripts/setup.sh"
  }
}
