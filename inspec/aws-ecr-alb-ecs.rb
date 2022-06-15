# See https://docs.chef.io/inspec/resources/#aws

input('environment', value: 'testing') # There must be a default value or
describe input('environment') do
  it { should be_in [ 'testing', 'staging', 'prod', 'old-test', 'old-stage', 'old-prod' ] }
end

content = inspec.profile.file("output.json")
params = JSON.parse(content)

ALB_ARN = params['ecs_lb01']['value']['arn']
AWS_REGION = ENV['AWS_REGION']
ECRS = [ 'one', 'two' ]
DOMAIN = input('environment') + '.example.com.'

ECRS.each do |ecr|
  describe aws_ecr_repository(repository_name: ecr+'-'+input('environment')) do
    it { should exist }
    its('image_tag_mutability') { should eq 'IMMUTABLE' }
    its('tags') { should include(
      'owner'   => 'devops',
      'slack'   => 'devops'
    )}
    its('image_scanning_configuration.scan_on_push') { should eq true}
  end
end

describe aws_ecs_cluster(cluster_name: input('environment')+'-'+AWS_REGION) do
  it { should exist }
  its( 'status' ) { should eq 'ACTIVE' }
end

describe aws_alb(load_balancer_arn: ALB_ARN) do
  it { should exist }
  its('load_balancer_name') { should cmp input('environment') + '-' + AWS_REGION }
  its('protocols') { should be_in [ "HTTPS", "HTTP" ] }
  its('zone_names.count')  { should be > 1 }
  its('external_ports') { should include 80 }
  its('external_ports') { should include 443 }
end
