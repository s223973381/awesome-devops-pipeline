
output "app_url" {
  value = "https://${azurerm_app_service.app.default_site_hostname}"
}
