run "validate_vm_size" {
  command = plan

  assert {
    condition     = resource.azurerm_linux_virtual_machine.vm.size == "Standard_B1s"
    error_message = "Expected VM size to be Standard_B1s"
  }
}

run "validate_admin_username" {
  command = plan

  assert {
    condition     = resource.azurerm_linux_virtual_machine.vm.admin_username == "azureuser"
    error_message = "Expected admin username to be azureuser"
  }
}

run "validate_ssh_key_path" {
  command = plan

  assert {
    condition = anytrue([
  for key in resource.azurerm_linux_virtual_machine.vm.admin_ssh_key : 
  key.public_key != ""
])
    error_message = "SSH public key should not be empty"
  }
}

run "validate_public_ip_association" {
  command = apply

  assert {
    condition     = resource.azurerm_network_interface.nic.ip_configuration[0].public_ip_address_id != ""
    error_message = "NIC must be associated with a public IP"
  }
}

run "validate_location" {
  command = apply

  assert {
    condition     = resource.azurerm_resource_group.vm_rg.location == "eastus"
    error_message = "Expected resource group to be in eastus"
  }
}