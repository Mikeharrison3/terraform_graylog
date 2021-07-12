variable "production_subnet" {
    type = string
}

variable "production" {
    type = string
}

variable "availability_zone" {
    description = "The availability zone that you want to use. Should be one in the aws_region"
    type = string
   # default = "us-east-1a" 
    }  

variable "private_cidr" {
  type = string
  
}

