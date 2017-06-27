# frozen_string_literal: true

require 'spec_helper'
require 'json'

env_file = './' + File.read('./.terraform/environment') + '.tfvars'
tfvars = JSON.parse(File.read(env_file))

#
# context
#
describe vpc(tfvars['context_vpc_name']) do
  it { should exist }
  it { should be_available }
  it { should have_route_table(tfvars['context_vpc_name'] + '-rt-public') }
  it { should have_tag('terraform').value('true') }
end

describe internet_gateway(tfvars['context_vpc_name'] + '-igw') do
  it { should exist }
  it { should be_attached_to(tfvars['context_vpc_name']) }
  it { should have_tag('terraform').value('true') }
end

tfvars['context_azs'].each do |az|
  describe subnet(tfvars['context_vpc_name'] + '-public-kube-subnet-' + az) do
    it { should exist }
    it { should have_tag('terraform').value('true') }
  end

  describe subnet(tfvars['context_vpc_name'] + '-public-alt-subnet-' + az) do
    it { should exist }
    it { should have_tag('terraform').value('true') }
  end

  describe subnet(tfvars['context_vpc_name'] + '-private-kube-subnet-' + az) do
    it { should exist }
    it { should have_tag('terraform').value('true') }
  end

  describe subnet(tfvars['context_vpc_name'] + '-private-alt-subnet-' + az) do
    it { should exist }
    it { should have_tag('terraform').value('true') }
  end

  describe subnet(tfvars['context_vpc_name'] + '-orchestration-kube-subnet-' + az) do
    it { should exist }
    it { should have_tag('terraform').value('true') }
  end

  describe subnet(tfvars['context_vpc_name'] + '-orchestration-alt-subnet-' + az) do
    it { should exist }
    it { should have_tag('terraform').value('true') }
  end

  describe route_table(tfvars['context_vpc_name'] + '-rt-public') do
    it { should exist }
    it { should have_route(tfvars['context_cidr']).target(gateway: 'local') }
    it { should have_subnet(tfvars['context_vpc_name'] + '-public-kube-subnet-' + az) }
    it { should have_subnet(tfvars['context_vpc_name'] + '-public-alt-subnet-' + az) }
    tfvars['context_route_to_vpc_pcx'].each_with_index do |pcx, i|
      it { should have_route(tfvars['context_route_to_vpc_cidr'][i]).target(vpc_peering_connection: tfvars['context_route_to_vpc_pcx'][i]) }
    end
  end

  describe route_table(tfvars['context_vpc_name'] + '-rt-private-' + az) do
    it { should exist }
    it { should have_route(tfvars['context_cidr']).target(gateway: 'local') }
    it { should have_subnet(tfvars['context_vpc_name'] + '-private-kube-subnet-' + az) }
    it { should have_subnet(tfvars['context_vpc_name'] + '-private-alt-subnet-' + az) }
    it { should have_subnet(tfvars['context_vpc_name'] + '-orchestration-kube-subnet-' + az) }
    it { should have_subnet(tfvars['context_vpc_name'] + '-orchestration-alt-subnet-' + az) }
    tfvars['context_route_to_vpc_pcx'].each_with_index do |pcx, i|
      it { should have_route(tfvars['context_route_to_vpc_cidr'][i]).target(vpc_peering_connection: tfvars['context_route_to_vpc_pcx'][i]) }
    end
  end
end

describe efs(tfvars['context_vpc_name'] + '-efs-share') do
  it { should exist }
  its(:number_of_mount_targets) {should eq(1)}
  it { should have_tag('terraform').value('true') }
end

if tfvars['context_is_management']  == 'false'
  describe vpc_peering_connection('peer-' + tfvars['context_vpc_name'] + '-to-vpc-management') do
    it { should exist }
    it { should be_active }
  end
end

describe security_group(tfvars['context_vpc_name'] + '-sg-admin') do
  it { should exist }

  its(:inbound) { should be_opened.protocol('icmp').for('0.0.0.0/0') }
  it { should have_tag('terraform').value('true') }
end

describe security_group(tfvars['context_vpc_name'] + '-sg-kube-node') do
  it { should exist }

  its(:inbound) { should be_opened(6783).protocol('tcp').for(tfvars['context_sg_node']) }
  its(:inbound) { should be_opened(6783).protocol('udp').for(tfvars['context_sg_node']) }
  its(:inbound) { should be_opened(10250).protocol('tcp').for(tfvars['context_sg_node']) }
  its(:inbound) { should be_opened(10255).protocol('tcp').for(tfvars['context_sg_node']) }
  its(:inbound) { should be_opened(443).protocol('tcp').for(tfvars['context_sg_node']) }

  # admin ports
  its(:inbound) { should be_opened(22).protocol('tcp').for(tfvars['context_management_sg_admin']) }

  its(:outbound) { should be_opened }
  it { should have_tag('terraform').value('true') }
end

describe security_group(tfvars['context_vpc_name'] + '-sg-kube-public') do
  it { should exist }

  its(:inbound) { should be_opened(30000).protocol('tcp').for('0.0.0.0/0') }
  its(:inbound) { should be_opened(32767).protocol('tcp').for('0.0.0.0/0') }
  it { should have_tag('terraform').value('true') }
end

describe security_group(tfvars['context_vpc_name'] + '-sg-kube-private') do
  it { should exist }
puts tfvars['context_management_sg_admin']
  its(:inbound) { should be_opened(30000).protocol('tcp').for(tfvars['context_sg_node']) }
  its(:inbound) { should be_opened(32767).protocol('tcp').for(tfvars['context_sg_node']) }
  its(:inbound) { should be_opened(30000).protocol('tcp').for(tfvars['context_management_sg_admin']) }
  its(:inbound) { should be_opened(32767).protocol('tcp').for(tfvars['context_management_sg_admin']) }
  it { should have_tag('terraform').value('true') }
end

describe security_group(tfvars['context_vpc_name'] + '-sg-alt') do
  it { should exist }

  its(:inbound) { should be_opened(2049).protocol('tcp').for(tfvars['context_sg_private']) }
  it { should have_tag('terraform').value('true') }
end