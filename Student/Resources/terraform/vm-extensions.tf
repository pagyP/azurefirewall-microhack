
##########################################################
## Install DNS role on onprem and AZ DNS servers
##########################################################
resource "azurerm_virtual_machine_extension" "install-iis" {

  name                 = "install-iis"
  virtual_machine_id   = azurerm_virtual_machine.azbrsouthvm01.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  settings = <<SETTINGS
    {
        "commandToExecute": "powershell.exe -ExecutionPolicy Unrestricted Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools; exit 0"
    }
SETTINGS
}


