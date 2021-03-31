#!/usr/bin/env ruby
#
# -*- mode: ruby -*-
# vi: set ft=ruby :
#

content = inspec.profile.file('terraform.json')
params = JSON.parse(content)

token     = params['token']['value']
url       = params['url']['value']
namespace = params['namespace']['value']
path_dev  = params['path_dev']['value']
path_prd  = params['path_prd']['value']

title "Vault Integration Test"

control "vlt-1.0" do
  impact 0.7
  title "Test health"
  desc "Test health"
  describe http("#{url}/v1/sys/health?perfstandbyok=true",
              method: 'GET') do
    its('status') { should eq 200 }
  end
end

control "vlt-2.0" do
  impact 0.7
  title "Validate access to Dev TFC Token"
  desc "Validate access to Dev TFC Token"
  describe http("#{url}/v1/#{namespace}#{path_dev}",
              method: 'GET',
              headers: {'X-Vault-Token' => "#{token}"}) do
    its('status') { should eq 200 }
  end
end

control "vlt-3.0" do
  impact 0.7
  title "Successful deny of prod TFC token by dev vault identity"
  desc "Successful deny of prod TFC token by dev vault identity"
  describe http("#{url}/v1/#{namespace}#{path_prd}",
              method: 'GET',
              headers: {'X-Vault-Token' => "#{token}"}) do
    its('status') { should eq 403 }
  end
end
