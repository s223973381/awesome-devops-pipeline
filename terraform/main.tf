provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id

  resource_provider_registrations = "none"
}

# Use existing Resource Group
data "azurerm_resource_group" "rg" {
  name = "awesome-devops-staging-rg"
}

# Use existing Service Plan
data "azurerm_service_plan" "plan" {
  name                = "awesome-devops-staging-plan"
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Create/Update Web App
resource "azurerm_linux_web_app" "app" {
  name                = "awesome-devops-${var.env}-app"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  service_plan_id     = data.azurerm_service_plan.plan.id

  site_config {
    application_stack {
      docker_image_name        = "${var.acr_login_server}/awesome-devops-app"
      docker_image_tag         = var.image_tag
      docker_registry_url      = "https://${var.acr_login_server}"
      docker_registry_username = var.acr_username
      docker_registry_password = var.acr_password
    }
  }

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
  }
}
