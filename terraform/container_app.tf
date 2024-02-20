resource "azurerm_container_app_environment" "juicy_app" {
  name                       = "cae-${local.stack}"
  location                   = azurerm_resource_group.juicy_app.location
  resource_group_name        = azurerm_resource_group.juicy_app.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.juicy_app.id

  tags = local.default_tags
}

resource "azurerm_container_app" "juicy_app" {
  name = "ca-${local.stack}"

  container_app_environment_id = azurerm_container_app_environment.juicy_app.id
  resource_group_name          = azurerm_resource_group.juicy_app.name
  revision_mode                = "Single"

  ingress {
    allow_insecure_connections = true
    external_enabled           = true
    target_port                = 80
    traffic_weight {
      percentage = 100
    }

  }

  template {
    container {
      name   = "juicyapp-ca"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      /*Should be https://docker.io/bkimminich/juice-shop:latest on https://registry.hub.docker.com/ but even this hangs when deploying*/
      cpu    = 0.5
      memory = "1Gi"
    }
  }
/*
  timeouts {
    create = "60m"
    update = "60m"
  }
*/
  tags = local.default_tags
}
