data "cloudinit_config" "cloudinit" {
  part {
    filename     = "cloud-config.yaml"
    content_type = "text/cloud-config"

    content = templatefile("${path.module}/templates/vm-cloud-init.yaml", {})
  }
}


resource "azurerm_resource_group" "rg" {
  for_each = toset(var.instances)
  name     = "lab-${var.project_name}-${each.key}-rg"
  location = var.azure_location
}


resource "azurerm_virtual_network" "vnet" {
  for_each            = azurerm_resource_group.rg
  name                = "lab-${var.project_name}-${each.key}-vnet"
  location            = each.value.location
  resource_group_name = each.value.name
  address_space       = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "server" {
  for_each             = azurerm_virtual_network.vnet
  name                 = "server"
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.name
  address_prefixes     = ["10.0.0.0/25"]
}

resource "azurerm_subnet" "postgres" {
  for_each             = azurerm_virtual_network.vnet
  name                 = "postgres"
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.name
  address_prefixes     = ["10.0.0.128/25"]
}


resource "azurerm_network_security_group" "nsg" {
  for_each            = azurerm_resource_group.rg
  name                = "lab-${var.project_name}-${each.key}-nsg"
  location            = each.value.location
  resource_group_name = each.value.name

  # Inbound rules
  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefixes    = var.vm_allowed_ssh_ips
    destination_port_range     = "22"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Grafana"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefixes    = var.vm_allowed_ssh_ips
    destination_port_range     = "3000"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefixes    = var.vm_allowed_ssh_ips
    destination_port_range     = "8080"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "server" {
  for_each                  = azurerm_subnet.server
  subnet_id                 = each.value.id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}


resource "azurerm_public_ip" "pip" {
  for_each            = azurerm_resource_group.rg
  name                = "lab-${var.project_name}-${each.key}-pip"
  location            = each.value.location
  resource_group_name = each.value.name
  allocation_method   = "Static"
  domain_name_label   = "lab-${var.project_name}-${each.key}"
  sku                 = "Basic"
}


resource "azurerm_network_interface" "nic" {
  for_each            = azurerm_resource_group.rg
  name                = "lab-${var.project_name}-${each.key}-nic"
  location            = each.value.location
  resource_group_name = each.value.name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = azurerm_subnet.server[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[each.key].id
  }
}


resource "azurerm_linux_virtual_machine" "vm" {
  for_each                        = azurerm_resource_group.rg
  name                            = "lab-${var.project_name}-${each.key}-vm"
  location                        = each.value.location
  resource_group_name             = each.value.name
  size                            = var.vm_sku
  computer_name                   = "lab-${var.project_name}-${each.key}"
  admin_username                  = each.key
  admin_password                  = "${each.key}${var.vm_admin_password_suffix}"
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id
  ]

  os_disk {
    name                 = "lab-${var.project_name}-${each.key}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  patch_mode     = "AutomaticByPlatform"
  reboot_setting = "IfRequired"

  custom_data = data.cloudinit_config.cloudinit.rendered

  # lifecycle {
  #   ignore_changes = [
  #     custom_data,
  #   ]
  # }
}
