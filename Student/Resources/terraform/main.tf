provider "azurerm" {
  version = "=2.64.0"
  features {}
}

#######################################################################
## Create Resource Group
#######################################################################

resource "azurerm_resource_group" "firewall-microhack-rg" {
  name     = "wth-azurefirewall-rg"
  location = "eastus2"

  tags = {
    environment = "wth"
    deployment  = "terraform"
    wth   = "Network Security with Azure Firewall Premium"
  }
}