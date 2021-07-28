output "natGateWay" {
    value = aws_nat_gateway.natGateway.id
}

output "natroutetable" {
    value = aws_route_table.elastic_route_table.id
}

output "nat_ip" {
    value = aws_eip.natGateway.public_ip
}

output "nat_subnet" {
    value = aws_subnet.nat_subnet.id
}

output "elastic_security" {
    value = aws_security_group.natgroup.id
}