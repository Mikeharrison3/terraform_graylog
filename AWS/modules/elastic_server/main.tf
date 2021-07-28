data "aws_ami" "ubuntu" {
    most_recent = true
    filter {
       name = "name"
       values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20210430"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
    owners = ["099720109477"]
}

resource "aws_network_interface" "private_interface" {
    subnet_id = var.nat_subnet
    security_groups = [var.elastic_security]
 
}

data "template_file" "init" {
  template = file("elastic.sh.tpl")

  vars = {
  }
}


resource "aws_instance" "elastic-server" {

    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.small"
    availability_zone = var.availability_zone
  
    key_name = "Laptop"

     network_interface {
         device_index = 0
         network_interface_id = aws_network_interface.private_interface.id
     }

    user_data = data.template_file.init.rendered
            
    
    tags = {
        Name = "elastic-server"
    }
}