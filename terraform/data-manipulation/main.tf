locals {
   # Here we delete unwanted keys from map derived from a json file
   env_vars = jsondecode(file("var.json"))

   # Exclude these keys
   excludes = [
      "AWS_SECRET_ACCESS_KEY",
      "AWS_ACCESS_KEY_ID"
   ]

   # Make a new map excluding unwanted keys
   env_vars_cleaned = { 
      for k,v in local.env_vars : k => v if ! contains( local.excludes, k )
   }
}


output env_vars {
   value = local.env_vars
}

output env_vars_cleaned {
   value = local.env_vars_cleaned
}
