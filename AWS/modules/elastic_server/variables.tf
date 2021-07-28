
variable "nat_subnet" { 
    type = string
}

variable "production-prod" {
    type = string
}

variable "allow-web" {
    type = string
}

variable "elastic_security" {
    type = string
}

variable "availability_zone" {
    description = "The availability zone that you want to use. Should be one in the aws_region"
    type = string
    }  
    

    variable "instance_count" {
    description = "The number of Granfa instances that you want to start"
    type = number
    default = 1
}

