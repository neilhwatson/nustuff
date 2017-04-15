#
# Vars
#
# SSH port
variable "ssh"      { default = 22 }
# SSH src IP address
variable "ssh_src"  { }

variable "location" { }
variable "resgroup" { }


resource "azurerm_network_security_group" "default" {
   name                = "default"
   location            = "${var.location}"
   resource_group_name = "${var.resgroup}"

#
# TODO add rules as needed by copying this block and making desired changes.
# The given rule allows inbound to port 22 from anywhere.
	security_rule {
		  name                       = "ssh_in"
		  priority                   = 100
		  direction                  = "Inbound"
		  access                     = "Allow"
		  protocol                   = "Tcp"
		  source_address_prefix      = "${var.ssh_src}"
		  source_port_range          = "*"
		  destination_port_range     = "${var.ssh}"
		  destination_address_prefix = "*"
	}
}
