# This finds the default VPC
# See https://docs.chef.io/inspec/resources/aws_vpc/

describe aws_vpc do
  it { should exist }
end


