provider "azurerm" {
  features {}
}

variable "env" {}

resource "azurerm_resource_group" "rg" {
  name     = "awesome-devops-${var.env}-rg"
  location = "Australia East"
}

resource "azurerm_app_service_plan" "plan" {
  name                = "awesome-devops-${var.env}-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "B1"
    size = "B1"
  }
}

resource "azurerm_app_service" "app" {
  name                = "awesome-devops-${var.env}-app"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.plan.id

  site_config {
    linux_fx_version = "DOCKER|${var.image_name}"
  }

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
    DOCKER_REGISTRY_SERVER_URL          = "https://${var.acr_login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME     = var.acr_username
    DOCKER_REGISTRY_SERVER_PASSWORD     = var.acr_password
  }
}

