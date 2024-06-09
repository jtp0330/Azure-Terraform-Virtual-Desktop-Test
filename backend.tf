terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.107.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "vdesktoptfstate" #storage account created from 'app' child module
    container_name       = "tfstate"
    key                  = "terrafrom.tfstate"
  }

}

provider "azurerm" {
  features {}
}

module "app" {
  source         = "./app"
  admin_username = admin_username
  admin_password = admin_password
}


module "network" {
  source         = "./network"
  admin_username = admin_username
  admin_password = admin_password
}