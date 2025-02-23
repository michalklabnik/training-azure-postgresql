output "resource_groups" {
  description = "List of created Resource Groups"
  value       = [for rg in azurerm_resource_group.rg : rg.name]
}

output "ssh_access" {
  description = "SSH connection details for each VM"
  value = {
    for vm_name, pip in azurerm_public_ip.pip :
    vm_name => "ssh ${vm_name}@${pip.domain_name_label}.${replace(lower(azurerm_resource_group.rg[vm_name].location), " ", "")}.cloudapp.azure.com (${pip.ip_address})"
  }
}
