data "aws_ami" "ubuntu" {
    most_recent = true
    filter {
       name = "name"
       values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20210430"]
       #values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
    owners = ["099720109477"]
}

data "template_file" "init" {
  template = file("InstallGraylog.sh.tpl")

  vars = {
    test_var = "testdot.txt"
    elasticIP = var.elasticIP
    publicIP = var.publicIP
    privateIP = var.privateIP
  }
}

resource "aws_instance" "graylog-server" {
  #ubuntu #'3micro free tier
    ami = data.aws_ami.ubuntu.id #ami-09e67e426f25ce0d7"
    instance_type = "t2.small"
    availability_zone = var.availability_zone
  
    key_name = "Laptop"

    network_interface {
        device_index = 0
        network_interface_id = var.production_interface
    }

    user_data = data.template_file.init.rendered
    
    tags = {
        Name = "graylog-server"
    }
}

