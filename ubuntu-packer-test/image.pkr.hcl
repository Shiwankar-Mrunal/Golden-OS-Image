// Main Packer template for Azure Ubuntu image

packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 2"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }

  }
}



# -------------------
# Azure ARM builder
# -------------------
source "azure-arm" "ubuntu" {
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id

  managed_image_resource_group_name = var.resource_group_name
  managed_image_name = "ubuntu-${var.image_sku}-${formatdate("DDMMMYYYY", timestamp())}"

  os_type          = "Linux"
  image_publisher  = var.image_publisher
  image_offer      = var.image_offer
  image_sku        = var.image_sku
  image_version    = var.image_version

  location = var.location
  vm_size = var.vm_size

  ssh_username = "azureuser"
  ssh_timeout  = "30m"

  temp_resource_group_name = "${var.resource_group_name}-temp-rg"
}

# -------------------
# Build definition
# -------------------
build {
  sources = ["source.azure-arm.ubuntu"]

  provisioner "ansible" {
    playbook_file = "ansible/playbook.yml"
    user          = "azureuser"
  }
}
