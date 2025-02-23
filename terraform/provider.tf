terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.20.0"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "2.3.5"
    }
  }

  required_version = "1.9.0"
}

provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
}

provider "cloudinit" {}
