resource "azurerm_resource_group" "resource_group" {
  name     = "group"
  location = var.region 
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "VPC" {
  name                = "VPC-network"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  address_space       = ["10.0.0.0/16"] #TODO move to var.
}


resource "azurerm_subnet" "public" {
  name                 = "public-subnet"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.VPC.name
  address_prefixes     = ["10.0.1.0/24"]

 # delegation {
 #   name = "delegation"

#    service_delegation {
 #     name    = "Microsoft.ContainerInstance/containerGroups"
#      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
#    }
#  }
}