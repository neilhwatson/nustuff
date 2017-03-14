#!/bin/sh

# Usage tfazure.sh [plan|apply|destroy] or other terraform command.
action=$1

# Fill in your credentails here or use some other environment method.
export ARM_SUBSCRIPTION_ID='xxxxx'
export ARM_CLIENT_ID='xxxxx'
export ARM_CLIENT_SECRET='xxxxxx'
export ARM_TENANT_ID='xxxxxx'

# This is the access from Azure's container. Get it from Azure
export ARM_ACCESS_KEY='xxxxxx'

# Setup remote state storage.
terraform remote config \
   -backend=azure \
   -backend-config="storage_account_name=myterraform" \
   -backend-config="container_name=terraform-state" \
   -backend-config="key=my.terraform.tfstate" \
   -backend-config="access_key=${ARM_ACCESS_KEY}"

# Run terraform action
terraform $action
