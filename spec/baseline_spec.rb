# frozen_string_literal: true

require 'spec_helper'
require 'json'

env_file = './' + File.read('./.terraform/environment') + '.tfvars'
tfvars = JSON.parse(File.read(env_file))

#
# context
#
describe vpc(tfvars['context-vpc-name']) do
  it { should exist }
  it { should be_available }
  it { should have_route_table(tfvars['context-vpc-name'] + '-rt-public') }
  it { should have_tag('terraform').value('true') }
end

describe internet_gateway(tfvars['context-vpc-name'] + '-igw') do
  it { should exist }
  it { should be_attached_to(tfvars['context-vpc-name']) }
  it { should have_tag('terraform').value('true') }
end

tfvars['context-azs'].each do |az|
  describe subnet(tfvars['context-vpc-name'] + '-public-kube-subnet-' + az) do
    it { should exist }
    it { should have_tag('terraform').value('true') }
  end

  describe subnet(tfvars['context-vpc-name'] + '-public-alt-subnet-' + az) do
    it { should exist }
    it { should have_tag('terraform').value('true') }
  end

  describe subnet(tfvars['context-vpc-name'] + '-private-kube-subnet-' + az) do
    it { should exist }
    it { should have_tag('terraform').value('true') }
  end

  describe subnet(tfvars['context-vpc-name'] + '-private-alt-subnet-' + az) do
    it { should exist }
    it { should have_tag('terraform').value('true') }
  end

  describe subnet(tfvars['context-vpc-name'] + '-orchestration-kube-subnet-' + az) do
    it { should exist }
    it { should have_tag('terraform').value('true') }
  end

  describe subnet(tfvars['context-vpc-name'] + '-orchestration-alt-subnet-' + az) do
    it { should exist }
    it { should have_tag('terraform').value('true') }
  end

  describe route_table(tfvars['context-vpc-name'] + '-rt-public') do
    it { should exist }
    it { should have_route(tfvars['context-cidr']).target(gateway: 'local') }
    it { should have_subnet(tfvars['context-vpc-name'] + '-public-kube-subnet-' + az) }
    it { should have_subnet(tfvars['context-vpc-name'] + '-public-alt-subnet-' + az) }
  end

  describe route_table(tfvars['context-vpc-name'] + '-rt-private-' + az) do
    it { should exist }
    it { should have_route(tfvars['context-cidr']).target(gateway: 'local') }
    it { should have_subnet(tfvars['context-vpc-name'] + '-private-kube-subnet-' + az) }
    it { should have_subnet(tfvars['context-vpc-name'] + '-private-alt-subnet-' + az) }
    it { should have_subnet(tfvars['context-vpc-name'] + '-orchestration-kube-subnet-' + az) }
    it { should have_subnet(tfvars['context-vpc-name'] + '-orchestration-alt-subnet-' + az) }
  end
end

#
# describe security_group('vpc-sg-prod-bootstrap-instance') do
#   it { should exist }
#   its(:inbound) { should be_opened(443).protocol('tcp').for('0.0.0.0/0') }
#   its(:inbound) { should be_opened(22).protocol('tcp').for('0.0.0.0/0') }
#   its(:inbound) { should be_opened(2376).protocol('tcp').for('0.0.0.0/0') }
#   its(:inbound) { should be_opened(3376).protocol('tcp').for('0.0.0.0/0') }
#   it { should have_tag('terraform').value('true') }
#   it { should have_tag('bootstrap').value('true') }
# end
#
# describe iam_policy('bootstrap-host-policy') do
#   it { should exist }
#   it { should be_attachable }
#   it { should be_attached_to_role('bootstrap-host-role') }
# end
#
# describe iam_role('bootstrap-host-role') do
#   it { should exist }
#   it { should be_allowed_action('ec2:DescribeInstances') }
# end
#
# describe efs('bootstrap-efs') do
#   it { should exist }
#   its(:number_of_mount_targets) {should eq(1)}
#   it { should have_tag('terraform').value('true') }
#   it { should have_tag('bootstrap').value('true') }
# end
