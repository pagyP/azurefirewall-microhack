provider "azurerm" {
  version = "=2.46.0"
  features {}
}

#######################################################################
## Create Resource Group
#######################################################################

resource "azurerm_resource_group" "firewall-microhack-rg" {
  name     = "firewall-microhack-rg"
  location = "eastus2"

  tags = {
    environment = "microhack"
    deployment  = "terraform"
    microhack   = "Firewall and Firewall Manager"
  }
}