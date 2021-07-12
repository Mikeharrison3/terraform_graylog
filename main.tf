terraform {
    required_providers {
      aws = {
          source = "hashicorp/aws"
      }
    }
}

provider "aws" {
    region = var.aws_region
}

#Pulls the available zones in the region.
data "aws_availability_zones" "available" {
    state = "available"
}

module "vpc" {
    source = "./modules/vpc"

    availability_zone = data.aws_availability_zones.available.names[1]
    vpc_cidr_block = var.vpc_cidr_block
}

module "nat" {
    source = "./modules/nat"

    availability_zone = data.aws_availability_zones.available.names[1]
    production_subnet = module.vpc.production_subnet
    production = module.vpc.production
    private_cidr = var.private_subnet
}

module "elastic" {

    source = "./modules/elastic_server"

    availability_zone = data.aws_availability_zones.available.names[1]
    nat_subnet = module.nat.nat_subnet
    production-prod = module.vpc.production
    allow-web = module.nat.elastic_security
    elastic_security = module.nat.elastic_security
    
  
}

module "server" {

    source = "./modules/graylog_server"

    availability_zone = data.aws_availability_zones.available.names[1]
    production_interface = module.vpc.private_interface
    production_subnet = module.vpc.production_subnet
    production-prod = module.vpc.production
    allow-web = module.vpc.allow-web
    elasticIP = module.elastic.elastic_private_ip
    publicIP = module.vpc.publicIP
    privateIP = module.vpc.privateIP
  
}