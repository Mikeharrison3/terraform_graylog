
variable "vpc_cidr_block" {
    description = "Default CIDR block for the VPC"
    type = string
    default = "172.20.0.0/16"
}


    variable "vpc_subnet" {
    description = "Subnet for inside of VPC"
    type = string
    default = "172.20.100.0/24" 
}

    variable "private_subnet" {
      type = string
      default = "172.20.101.0/24"
    }

variable "aws_region" {
    description = "Your prefered region"
    type = string
    default = "us-east-1"
}