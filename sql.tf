/*
resource "azurerm_mssql_server" "sql" {
  name                         = "${var.org}-sql-server"
  resource_group_name          = azurerm_resource_group.resourcegroup.name
  location                     = azurerm_resource_group.resourcegroup.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "P@ssw0rd!"
}

resource "azurerm_mssql_database" "sqldb" {
  name           = "${var.org}-db"
  server_id      = azurerm_mssql_server.sql.id
  license_type   = "LicenseIncluded"
  sku_name       = "GP_Gen5_2"
  zone_redundant = false

  tags = {
    environment = "${var.environment}"
  }
}

resource "azurerm_mssql_virtual_network_rule" "sqlvnet" {
  name      = "${var.org}-sql-vnet-rule"
  server_id = azurerm_mssql_server.sql.id
  subnet_id = azurerm_subnet.subnet_internal.id
}

*/