// Main Packer template for Azure Ubuntu image

packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 2.0"
    }
  }
  required_plugins{
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1.0"
    }

  }
}



# -------------------
# Source Block – Azure ARM Builder
# -------------------
source "azure-arm" "ubuntu" {
  use_azure_cli_auth = true
  managed_image_resource_group_name = var.resource_group_name
  managed_image_name = "ubuntu-${var.image_sku}-${formatdate("DDMMMYYYY", timestamp())}"

  os_type          = "Linux"
  image_publisher  = var.image_publisher
  image_offer      = var.image_offer
  image_sku        = var.image_sku
  image_version    = var.image_version

  location = var.location
  vm_size = var.vm_size


  temp_resource_group_name = "${var.resource_group_name}-temp-rg"
}

# -------------------
# Build Block – Build Definition
# -------------------
build {
  sources = ["source.azure-arm.ubuntu"]

  provisioner "ansible" {
    playbook_file = "ansible/playbook.yml"
    user          = "azureuser"

  }
}
