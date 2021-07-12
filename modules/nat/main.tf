
resource "aws_eip" "natGateway" {
    vpc = true

}

resource "aws_subnet" "nat_subnet" {
    availability_zone = var.availability_zone
    cidr_block = var.private_cidr
    vpc_id = var.production
}

resource "aws_nat_gateway" "natGateway" {
  allocation_id = aws_eip.natGateway.id
  subnet_id =  var.production_subnet

}

resource "aws_route_table" "elastic_route_table" {
    vpc_id = var.production

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.natGateway.id
    }

    tags = {
        Name = "route table"
    }
}

resource "aws_route_table_association" "instance" {
    subnet_id = aws_subnet.nat_subnet.id
    route_table_id = aws_route_table.elastic_route_table.id
}

resource "aws_security_group" "natgroup" {
     name = "Nat_Security_Group"
 
  vpc_id = var.production
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
   ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 9200
    to_port = 9200
    protocol = "tcp"
  }
     ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 9200
    to_port = 9200
    protocol = "udp"
  }

     ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 9300
    to_port = 9300
    protocol = "tcp"
  }
     ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 9300
    to_port = 9300
    protocol = "udp"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
  tags = {
    "Name" = "Nat_Security_Group"
  }
}