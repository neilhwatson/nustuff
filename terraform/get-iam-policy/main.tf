variable policy_arns { type = list }

data aws_iam_policy p01 {
   count = length(var.policy_arns)
   arn   = var.policy_arns[count.index]
}

locals {

   policies = [
      for p in data.aws_iam_policy.p01 : {
         name = p.name
         path = p.path
         description = p.description
         policy = jsondecode(p.policy)
      }
   ]
}

output policies {
   value = local.policies
}

# Get final json with `terraform output policies` and use as a vars file
