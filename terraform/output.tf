# azurerm_container_app_url is where we'll be able to access the app

output "azurerm_container_app_url" {
  value = azurerm_container_app.juicy_app.latest_revision_fqdn
}
