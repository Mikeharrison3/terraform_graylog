output "resource_location" {
    value = azurerm_resource_group.resource_group.location
}

output "resource_name" {
    value = azurerm_resource_group.resource_group.name
}

output "subnet_id" {
    value = azurerm_subnet.public.id
}