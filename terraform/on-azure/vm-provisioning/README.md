### Intro

This collection of [Terraform](http://terraform.io) files provisions a group of VMs in Azure. 

### setup

1. Create a working copy of `vm-provision-template`.
1. Create [Azure](https://www.terraform.io/docs/backends/types/azure.html) storage for Terraform [state](https://www.terraform.io/docs/state/index.html).
1. In the `terraform` section of `00_main.tf` and in `tf-init.sh`, set the Terraform state location to the storage you just created.
1. In `creds` fill out your Azure creds and `source` it. Guard this.
1. Run `tf-init.sh` to initialize or import Terraform's state.
1. `terraform get` to load [modules](https://www.terraform.io/docs/modules/index.html). Repeat this if you add terraform modules.

### Configure Terraform code

1. Edit `vars` section in `00_main.tf`.
1. If desired, add any extra firewall (security group) rules in `security/main.tf`.
1. Add an `azurerm_public_ip` resource and outputs section of `00_main.tf` for every VM you want created.
1. Add module vm blocks for every VM you need. Be sure to increment the module name, the name parameter, and the two public IP parameters.
1. Edit the Ansible playbook, `playbook.yml` as required. Add extra playbooks if required and give the playbooks as parameters in the vm module blocks. See `.vim/host01/main.tf`.

### Running

1. `terraform plan` Have terraform show what will be done.
1. `terraform apply` Build and provision it all.
1. Test and use your environment. 
1. `terraform destroy` Destroy your environment. All info on hosts will be lost. Public IPs will be released, you'll get new ones the next time you build.

### Further reading:

- (http://terraform.io)
- (http://watson-wilson.ca/blog/tag/terraform/)
- (https://blogs.msdn.microsoft.com/eugene/2016/11/03/creating-azure-resources-with-terraform/)
- (https://groups.google.com/forum/#!forum/terraform-tool)
