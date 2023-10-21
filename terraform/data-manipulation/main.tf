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
    for k, v in local.env_vars : k => v if !contains(local.excludes, k)
  }

  # Try to encode json
  some_def = jsonencode(
    {
      name  = "task1"
      owner = "neil"
      env   = local.env_vars_cleaned
    }
  )

  # Read json file but mark it sensitive
  secret_vars = sensitive(jsondecode(file("var.json")))
}

module "m" {
  source = "./module"
  security_group_rules = {
    rule1 = {
      from_port   = 123
      to_port     = 123
      protocol    = "tcp"
      description = "OVERRIDE"
      cidr_blocks = ["1.1.1.1"]
    }
    rule3 = {
      from_port   = 456
      to_port     = 456
      protocol    = "tcp"
      description = "NEW"
      cidr_blocks = ["2.2.2.2"]
    }
  }
}

output "security_group_rules" {
  value = module.m.security_group_rules
}

output "env_vars" {
  value = local.env_vars
}

output "env_vars_cleaned" {
  value = local.env_vars_cleaned
}

output "some_def" {
  value = local.some_def
}

output "secret_vars" {
  value     = local.secret_vars
  sensitive = true
}
