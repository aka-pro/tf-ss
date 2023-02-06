resource "azurerm_virtual_network" "network" {
  name                = "${var.org}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
}

resource "azurerm_subnet" "subnet_internal" {
  name                 = "${var.org}-internal"
  resource_group_name  = azurerm_resource_group.resourcegroup.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = ["10.0.1.0/24"]
  service_endpoints    = ["Microsoft.Sql"]
}

resource "azurerm_subnet" "subnet_public" {
  name                 = "${var.org}-public"
  resource_group_name  = azurerm_resource_group.resourcegroup.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "NAT_GW_PIP" {
  name                = "${var.org}-NAT_GW_PIP-pip"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  ip_version          = "IPv4"
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "nat_gw" {
  name                = "${var.org}-nat_gw"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  sku_name            = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "nat_gw_pip_association" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gw.id
  public_ip_address_id = azurerm_public_ip.NAT_GW_PIP.id
}

resource "azurerm_subnet_nat_gateway_association" "nat_gw_association_public" {
  subnet_id      = azurerm_subnet.subnet_public.id
  nat_gateway_id = azurerm_nat_gateway.nat_gw.id
}

resource "azurerm_subnet_nat_gateway_association" "nat_gw_association_internal" {
  subnet_id      = azurerm_subnet.subnet_internal.id
  nat_gateway_id = azurerm_nat_gateway.nat_gw.id
}