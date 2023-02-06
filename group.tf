resource "azurerm_resource_group" "resourcegroup" {
  name     = "${var.org}_AZsqlDj"
  location = var.location
}