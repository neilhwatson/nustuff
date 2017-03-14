data "terraform_remote_state" "myterraform" {
  backend = "azure"
  config {
    storage_account_name = "myterraform"
    container_name       = "terraform-state"
    key                  = "my.terraform.tfstate"
  }
}

# Your terraform stuff below
