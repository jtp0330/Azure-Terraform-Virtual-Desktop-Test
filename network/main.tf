resource "azurerm_virtual_network" "vdisk" {
  name                = "vdisk-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.vdisk.location
  resource_group_name = azurerm_resource_group.vdisk.name
}

resource "azurerm_subnet" "vdisk" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.vdisk.name
  virtual_network_name = azurerm_virtual_network.vdisk.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "vdisk" {
  name                = "vdisk-nic"
  location            = azurerm_resource_group.vdisk.location
  resource_group_name = azurerm_resource_group.vdisk.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vdisk.id
    private_ip_address_allocation = "Dynamic"
  }
}

module "app" {
  source         = "../app"
  admin_username = var.admin_username
  admin_password = var.admin_password

}
