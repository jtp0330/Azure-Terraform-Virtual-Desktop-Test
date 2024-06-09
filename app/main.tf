resource "azurerm_resource_group" "vdesktop-01" {
  name     = "vdesktop-01-resources"
  location = "West Europe"
}

resource "azurerm_storage_account" "vdesktop-storage-01" {
  name                     = "vdesktop-storage-01"
  resource_group_name      = azurerm_resource_group.vdesktop-01.name
  location                 = azurerm_resource_group.vdesktop-01.location
  account_replication_type = "LRS"
  account_tier             = "BlockBlobStorage"
}
resource "azurerm_windows_virtual_machine" "vdesktop-vm-windows-01" {
  name                = "windows-vm-01"
  resource_group_name = azurerm_resource_group.vdesktop-01.name
  location            = azurerm_resource_group.vdesktop-01.location
  size                = ""
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    module.network.azurerm_network_interface.vdisk.id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

}
resource "azurerm_linux_virtual_machine" "vdesktop-vm-linux-01" {
  name                = "linux-vm-01"
  resource_group_name = azurerm_resource_group.vdesktop-01.name
  location            = azurerm_resource_group.vdesktop-01.location
  size                = ""
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    module.network.azurerm_network_interface.vdisk.id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

module "network" {
  source = "../network"
}
