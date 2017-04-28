#
# Vars
# Don't change these here, pass them as parameters. But study them so you 
# know what parameters this module will accept.
#
variable "adminuser"         { default = "ansible" }
variable "adminpasswd"       { default = "TODO Set your password here"}
variable "ansible_playbook"  { default = "playbook.yml" }
variable "key_data"          {}

# Anzure location/region
variable "location"          {}
variable "resgroup"          {}

# Hostname
variable "name"              {}
variable "public_ip"         {}
variable "public_ip_address" {}
variable "subnet"            {}

# VM OS
variable "publisher"         { default = "OpenLogic"}
variable "offer"             { default = "CentOS"}
variable "sku"               { default = "7.3"}
variable "version"           { default = "latest"}

variable "vmsize"            { default = "Standard_F1s"}
variable "storage_blobend"   {}
variable "storage_container" {}

#
# Networking
#
resource "azurerm_network_interface" "host01" {
  name                = "${var.name}"
  location            = "${var.location}"
  resource_group_name = "${var.resgroup}"

  ip_configuration {
    name                          = "${var.name}"
    subnet_id                     = "${var.subnet}"
    public_ip_address_id          = "${var.public_ip}"
    private_ip_address_allocation = "dynamic"
  }
}

#
# vm instance
#
resource "azurerm_virtual_machine" "host01" {
   name                  = "${var.name}"
   vm_size               = "${var.vmsize}"
   resource_group_name   = "${var.resgroup}"
   location              = "${var.location}"
   network_interface_ids = ["${azurerm_network_interface.test.id}"]

   storage_image_reference {
      sku       = "${var.sku}"
      offer     = "${var.offer}"
      version   = "${var.version}"
      publisher = "${var.publisher}"
   }

   storage_os_disk {
    vhd_uri       = "${var.storage_blobend}${var.storage_container}/${var.name}.vhd"
    name          = "${var.name}"
    caching       = "ReadWrite"
    create_option = "FromImage"
   }

   os_profile {
      computer_name  = "${var.name}"
      admin_username = "${var.adminuser}"
      admin_password = "${var.adminpasswd}"
   }

   os_profile_linux_config {
      disable_password_authentication = true
      ssh_keys    = {
         key_data = "${var.key_data}"
         path     = "/home/${var.adminuser}/.ssh/authorized_keys"
      }
   }
   
   # Build ansible inventory for this host.
   provisioner "local-exec" {
      command = "echo [all] > ${var.public_ip_address}.txt"
   }
   provisioner "local-exec" {
      command = "echo ${var.public_ip_address} >> ${var.public_ip_address}.txt"
   }

   # Launch ansible playbook
   provisioner "local-exec" {
      command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${var.public_ip_address}.txt ${var.ansible_playbook}"
   }
}

output "host_id" {
   value = "${azurerm_virtual_machine.id}"
}
