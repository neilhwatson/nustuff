#!/bin/sh

terraform init \
   -backend-config="access_key=${ARM_ACCESS_KEY}" \
   -backend-config="container_name=terraform-state" \
   -backend-config="storage_account_name=npterraform" \
   -backend-config="key=nwatson-test01.terraform.tfstate"

