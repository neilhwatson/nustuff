variable "security_group_rules" {
  type = map(object({
    from_port   = number
    to_port     = number
    protocol    = string
    description = string
    cidr_blocks = list(string)
  }))
  default = {}
}

locals {
  default_security_group_rules = {
    rule1 = {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "HTTP"
      cidr_blocks = ["0.0.0.0/0"]
    }
    rule2 = {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "HTTPS"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  final_security_group_rules = merge(
    local.default_security_group_rules,
    var.security_group_rules
  )
}

output "security_group_rules" {
  value = local.final_security_group_rules
}
