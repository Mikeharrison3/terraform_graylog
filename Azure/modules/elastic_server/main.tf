
resource "random_id" "storage_account" {
  byte_length = 8
}

  resource "azurerm_network_security_group" "inbound" {
  name                = "elastic${lower(random_id.storage_account.hex)}"
  resource_group_name = var.resource_name
  location            = var.resource_location

  tags = {
    environment = "Production"
  }
}

resource "azurerm_network_security_rule" "http" {
    name                       = "80"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80-80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
     resource_group_name         = var.resource_name
    network_security_group_name = azurerm_network_security_group.inbound.name
}




resource "azurerm_public_ip" "graylog_Server" {
  name                = "elastic${lower(random_id.storage_account.hex)}"
  resource_group_name = var.resource_name
  location            = var.resource_location
  allocation_method   = "Static"

}


resource "azurerm_network_interface" "server" {
  name                = "elastic${lower(random_id.storage_account.hex)}"
  location            = var.resource_location
  resource_group_name = var.resource_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.graylog_Server.id
  }
}

data "template_file" "init" {
  template = file("elastic.sh.tpl")

  vars = {
  }
}

resource "azurerm_network_interface_security_group_association" "security" {
  network_interface_id      = azurerm_network_interface.server.id
  network_security_group_id = azurerm_network_security_group.inbound.id
}

resource "azurerm_linux_virtual_machine" "graylog" {
  name                = "elastic${lower(random_id.storage_account.hex)}"
  resource_group_name = var.resource_name
  location            = var.resource_location
  size                = "Standard_B2ms"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.server.id,
  ]

  custom_data = base64encode(data.template_file.init.rendered) #filebase64("scripts/k8s-node.sh")

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
}