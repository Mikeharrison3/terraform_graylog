
resource "aws_vpc" "production" {
    cidr_block = var.vpc_cidr_block
}

resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.production.id

    tags = {
        Name = "Graylog-production-gateway"
    }
}


resource "aws_route_table" "production_route_table" {
    vpc_id = aws_vpc.production.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw.id
    }

    tags = {
        Name = "route table"
    }
}

resource "aws_subnet" "production_subnet" {
    vpc_id = aws_vpc.production.id
    cidr_block = var.vpc_subnet

    availability_zone = var.availability_zone

    tags = {
        Name = "production-subnet"
    }
}

resource "aws_route_table_association" "association_table" {
    subnet_id = aws_subnet.production_subnet.id
    route_table_id = aws_route_table.production_route_table.id
   # route_table_id = aws_route_table.production_route_table.id
}

resource "aws_security_group" "allow-web" {
    name = "allow-web"
    
    vpc_id = aws_vpc.production.id

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Graylog Web"
        from_port = 9000
        to_port = 9000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "Allow-web"
    }
}

resource "aws_network_interface" "private_interface" {
    subnet_id = aws_subnet.production_subnet.id
    private_ips = ["172.20.100.50"]
    security_groups = [aws_security_group.allow-web.id]
}

resource "aws_eip" "one" {
    vpc = true
    network_interface = aws_network_interface.private_interface.id
        associate_with_private_ip = "172.20.100.50"
}


