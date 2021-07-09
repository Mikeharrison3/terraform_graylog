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