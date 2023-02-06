resource "azurerm_network_security_group" "securitygroup" {
  name                = "${var.org}-nsg"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
}

resource "azurerm_network_security_rule" "allow_22" {
  name                        = "allow-ssh"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.resourcegroup.name
  network_security_group_name = azurerm_network_security_group.securitygroup.name
}

resource "azurerm_network_security_rule" "allow_8000" {
  name                        = "allow-8000"
  priority                    = 200
  direction                  = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "8000"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
  resource_group_name        = azurerm_resource_group.resourcegroup.name
  network_security_group_name = azurerm_network_security_group.securitygroup.name
}

resource "azurerm_network_security_rule" "allow_443" {
  name                        = "allow-443"
  priority                    = 300
  direction                  = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "443"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
  resource_group_name        = azurerm_resource_group.resourcegroup.name
  network_security_group_name = azurerm_network_security_group.securitygroup.name
}