output "private_interface" {
  value = aws_network_interface.private_interface.id
}

output "production_subnet" {
    value = aws_subnet.production_subnet.id
}

output "production" {
    value = aws_vpc.production.id
}

output "allow-web" {
    value = aws_security_group.allow-web.id
}

output "publicIP" {
    value = aws_eip.one.public_ip
}

output "privateIP" {
    value = aws_network_interface.private_interface.private_ip
}