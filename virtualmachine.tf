resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.org}-vm"
  location              = azurerm_resource_group.resourcegroup.location
  resource_group_name   = azurerm_resource_group.resourcegroup.name
  network_interface_ids = [azurerm_network_interface.NetInterface.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.org}-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "StandardSSD_LRS"
  }

  os_profile {
    computer_name  = "${var.org}-vm"
    admin_username = "azureuser"
    admin_password = "AzurePassword123!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_network_interface" "NetInterface" {
  name                = "${var.org}-nic"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name

  ip_configuration {
    name                          = "${var.org}-ipconf"
    subnet_id                     = azurerm_subnet.subnet_public.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip_App.id
  }
}

resource "azurerm_network_interface_security_group_association" "NIC_SG_association" {
  network_interface_id      = azurerm_network_interface.NetInterface.id
  network_security_group_id = azurerm_network_security_group.securitygroup.id
}

resource "azurerm_public_ip" "pip_App" {
  name                = "${var.org}-pip"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  ip_version          = "IPv4"
  sku                 = "Standard"
  allocation_method   = "Static"

  tags = {
    environment = "${var.environment}"
  }
}
/*
locals {
  network_interface_id = azurerm_virtual_machine.vm.network_interface_ids[0]
  network_interface    = azurerm_network_interface.NetInterface.private_ip_address
}


resource "null_resource" "configure" {

  connection {
    type     = "ssh"
    user     = "azureuser"
    password = "AzurePassword123!"
    host     = azurerm_public_ip.pip_App.ip_address
  }

  provisioner "file" {
    source      = "nginx.sh"
    destination = "./nginx.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x ./nginx.sh",
      "sudo ./nginx.sh"
    ]
  }
}
*/