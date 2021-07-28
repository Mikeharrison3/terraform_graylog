output "server_public_ip" {
    value = module.server.server_public_ip  
}

output "elastic_private_ip" {
    value = module.elastic.elastic_private_ip
}

output "natIP" {
    value = module.nat.nat_ip
}