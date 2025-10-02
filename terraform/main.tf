provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id

  resource_provider_registrations = "none"
}

# Remove RG resource, since it's pre-created manually

resource "azurerm_service_plan" "plan" {
  name                = "awesome-devops-${var.env}-plan"
  location            = "Australia East"
  resource_group_name = "awesome-devops-${var.env}-rg"
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "app" {
  name                = "awesome-devops-${var.env}-app"
  location            = "Australia East"
  resource_group_name = "awesome-devops-${var.env}-rg"
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    application_stack {
      docker_image_name        = "${var.acr_login_server}/awesome-devops-app:${var.image_tag}"
      docker_registry_url      = "https://${var.acr_login_server}"
      docker_registry_username = var.acr_username
      docker_registry_password = var.acr_password
    }
  }

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
  }
}
