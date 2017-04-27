#
# Backend for terraform state storage
#
terraform {
   backend "azure" {
      storage_account_name = "myterraform"
      container_name       = "terraform-state"
##### TODO rename this key ######
      key                  = "mykey.terraform.tfstate"
#                             ^^^^^^^^^^^^
   }
}

#
# TODO configure these variables
#
# Name resgroup after your project
variable "resgroup" { default = "myproject" }
variable "location" { default = "Canada East" }
variable "subnet"   { default = "172.16.100.0/24" }
# SSH public key that ansible will use for provisioning
variable "sshkey"   { default = "/home/nwatson/.ssh/id_rsa.pub" }
# Limit inbound ssh connections to vm to this network only
variable "ssh_src"  { default = "0.0.0.0/0" }

#
# Resource groups
#
resource "azurerm_resource_group" "group01" {
   name     = "${var.resgroup}"
   location = "${var.location}"
}

#
# Storage for VMs
#
resource "azurerm_storage_account" "storage01" {
   name                = "storage01"
   account_type        = "Standard_LRS"
   location            = "${var.location}"
   resource_group_name = "${azurerm_resource_group.group01.name}"
}

resource "azurerm_storage_container" "s_container01" {
   container_access_type = "private"
   name                  = "s_container01"
   resource_group_name   = "${azurerm_resource_group.group01.name}"
   storage_account_name  = "${azurerm_storage_account.storage01.name}"
}

#
# Networking
#
resource "azurerm_virtual_network" "net01" {
   name                = "net01"
   location            = "${var.location}"
   address_space       = ["${var.subnet}"]
   resource_group_name = "${azurerm_resource_group.group01.name}"

   subnet {
      name           = "subnet01"
      address_prefix = "${var.subnet}"
   } 
}

resource "azurerm_subnet" "subnet01" {
   name                 = "subnet01"
   address_prefix       = "${var.subnet}"
   virtual_network_name = "${azurerm_virtual_network.net01.name}"
   resource_group_name  = "${azurerm_resource_group.group01.name}"
}

#
# Public IPs. TODO add more if you need them.
# TODO add to outputs section at bottom to get a record of each.
#
resource "azurerm_public_ip" "ip01" {
   name                         = "ip01"
   public_ip_address_allocation = "static"
   location                     = "${var.location}"
   resource_group_name          = "${azurerm_resource_group.group01.name}"

}

module "security" {
   source   = "./security"
   ssh_src  = "${var.ssh_src}"
   location = "${var.location}"
   resgroup = "${azurerm_resource_group.group01.name}"
}

#
# Virtual machines. TODO Add one for every VM you need.
# See module code for avaiable parameters.
#
# TODO Change vm01 and h01 when you copy this module to make another vm.
module "vm01" {
   name              = "h01"

   # Shoud not need to change these.
   source            = "./vm/host01/"
   location          = "${var.location}"
   key_data          = "${file("${var.sshkey}")}"
   public_ip         = "${azurerm_public_ip.ip01.id}"
   subnet            = "${azurerm_subnet.subnet01.id}"
   public_ip_address = "${azurerm_public_ip.ip01.ip_address}"
   resgroup          = "${azurerm_resource_group.group01.name}"
   storage_container = "${azurerm_storage_container.s_container01.name}"
   storage_blobend   = "${azurerm_storage_account.storage01.primary_blob_endpoint}"
}

#
# Outputs
#
# TODO add an output for each public IP.
output "h01_ip" {
   value = "${azurerm_public_ip.ip01.ip_address}"
}
