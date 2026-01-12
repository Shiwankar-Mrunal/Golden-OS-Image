
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


#Definition: The company or organization that 
#provides the image in the Azure Marketplace.
#Canonical → for Ubuntu

variable "image_publisher" {
  type    = string
  default = "Canonical"
}

#Definition: The specific offer of the image
#It tells Azure which “offer” under the publisher” you want to use. 
#A publisher can have multiple offers

variable "image_offer" {
  type    = string
  default = "0001-com-ubuntu-server-jammy"
}

#Definition: The specific version of the image  
variable "image_sku" {
  type    = string
  default = "22_04-lts-gen2"
}

variable "image_version" {
  type    = string
  default = "latest"
}
