# vnet1 with subnet1
resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet1"
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "Dev"
  }
}

resource "azurerm_subnet" "s1" {
  name                 = "s1"
  virtual_network_name = azurerm_virtual_network.vnet1.name
  resource_group_name = azurerm_resource_group.demo.name
  address_prefixes     = ["10.0.0.0/24"]
}

# vnet2 with subnet2
resource "azurerm_virtual_network" "vnet2" {
  name                = "vnet2"
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name
  address_space       = ["10.1.0.0/16"]

  tags = {
    environment = "Dev"
  }
}

resource "azurerm_subnet" "s2" {
  name                 = "s2"
  virtual_network_name = azurerm_virtual_network.vnet2.name
  resource_group_name = azurerm_resource_group.demo.name
  address_prefixes     = ["10.1.0.0/24"]
}

# vnet-peering
resource "azurerm_virtual_network_peering" "peer1to2" {
  name                      = "peer1to2"
  resource_group_name       = azurerm_resource_group.demo.name
  virtual_network_name      = azurerm_virtual_network.vnet1.name
  remote_virtual_network_id = azurerm_virtual_network.vnet2.id
}

resource "azurerm_virtual_network_peering" "peer2to1" {
  name                      = "peer2to1"
  resource_group_name       = azurerm_resource_group.demo.name
  virtual_network_name      = azurerm_virtual_network.vnet2.name
  remote_virtual_network_id = azurerm_virtual_network.vnet1.id
}

