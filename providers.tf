provider "azurerm" {
  features {}
  skip_provider_registration = true

  # Region is configured per-resource via location argument
}