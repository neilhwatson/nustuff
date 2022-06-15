# This finds the default VPC
# See https://docs.chef.io/inspec/resources/aws_vpc/

content = inspec.profile.file("output.json")
params = JSON.parse(content)

VPC_ID = params['vpc']['value']['id']
ECS_SUBNETS = params['private_subnets']['value']['one']
NATGW_SUBNETS = params['public_subnets']['value']['two']
IPV4_CIDR_BLOCKS = params['vpc_cidr_blocks']['value']['ipv4']
IPV6_CIDR_BLOCKS = params['vpc_cidr_blocks']['value']['ipv6']

describe aws_vpc(vpc_id: VPC_ID) do
  it { should exist }
  it { should be_available }
  its('tags') { should include(
    'Name'    => 'main',
    'owner'   => 'devops',
    'slack'   => 'devops',
    'purpose' => 'general use'
  ) }
  its('cidr_block') { should cmp '10.77.0.0/16' }
end

ECS_SUBNETS.each do |subnet|
  puts subnet['id']
  describe aws_subnet(subnet_id: subnet['id']) do
    it { should exist }
    its('tags') { should include(
      'owner'   => 'devops',
      'slack'   => 'devops',
      'purpose' => 'private'
    )}
    its('cidr_block') { should be_in IPV4_CIDR_BLOCKS }
    # IPV6 block not supported :(
    # its('ipv6_cidr_block') { should be_in IPV6_CIDR_BLOCKS }
    # TODO check AZs
    its('map_public_ip_on_launch') { should be false }
    its('vpc_id') { should cmp VPC_ID }
  end
end

NATGW_SUBNETS.each do |subnet|
  puts subnet['id']
  describe aws_subnet(subnet_id: subnet['id']) do
    it { should exist }
    its('tags') { should include(
      'owner'   => 'devops',
      'slack'   => 'devops',
      'purpose' => 'Public subnets'
    )}
    its('cidr_block') { should be_in IPV4_CIDR_BLOCKS }
    # IPV6 block not supported :(
    # its('ipv6_cidr_block') { should be_in IPV6_CIDR_BLOCKS }
    # TODO check AZs
    its('map_public_ip_on_launch') { should be true }
    its('vpc_id') { should cmp VPC_ID }
  end
end
