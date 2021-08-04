terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "vpc" {
  source = "./modules/vpc"

  region = var.region
}

module "elastic" {

  source = "./modules/elastic_server"

  resource_location = module.vpc.resource_location
  resource_name = module.vpc.resource_name
  subnet_id = module.vpc.subnet_id
}

module "server" {
  count = 1

  source = "./modules/server"

  resource_location = module.vpc.resource_location
  resource_name = module.vpc.resource_name
  subnet_id = module.vpc.subnet_id
  depends_on = [
    module.elastic
  ]
  #Variables for Cloud-Init Script
  elasticIP = module.elastic.elasticIP
}
