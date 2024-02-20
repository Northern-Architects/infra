locals {
  stack = "${var.app}-${var.env}"

  default_tags = {
    environment = var.env
    owner       = "axdoomer"
    app         = var.app
  }
}

resource "azurerm_resource_group" "juicy_app" {
  name     = "rg-${local.stack}"
  location = var.region

  tags = local.default_tags
}

resource "azurerm_log_analytics_workspace" "juicy_app" {
  name                = /*"log-${local.stack}-4"*/ "log-juicyapp-dev"
  location            = azurerm_resource_group.juicy_app.location
  resource_group_name = azurerm_resource_group.juicy_app.name

  tags = local.default_tags
}
