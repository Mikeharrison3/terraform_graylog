output "elasticIP" {
    value = azurerm_network_interface.server.private_ip_address
}
