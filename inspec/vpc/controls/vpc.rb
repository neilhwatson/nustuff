# This finds the default VPC
# See https://docs.chef.io/inspec/resources/aws_vpc/

describe aws_vpc('vpc-3497eafeoin3048') do
  it { should exist }
  it { should be_available }
  its('tags') { should include(
    'Name'    => 'main',
    'owner'   => 'devops',
    'purpose' => 'general use'
  ) }
  its('cidr_block') { should cmp '10.88.0.0/16' }
end

describe aws_subnets.where(vpc_id: 'vpc-3497eafeoin3048') do
  it { should exist }
  its('availability_zone') { should include('ca-central-1a') }
  its('availability_zone') { should include('ca-central-1b') }
  its('availability_zone') { should include('ca-central-1d') }
  # its('tags') { should include({key: 'owner', value: 'devops'}) }
end


