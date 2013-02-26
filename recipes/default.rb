#
# Cookbook Name:: ipf
# Recipe:: default
#
# Copyright 2013, ModCloth, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

script "point ipfilter service at our .conf file" do
  interpreter "bash"
  user "root"
  code <<-EOH
  svccfg -s network/ipfilter:default setprop firewall_config_default/policy = astring: custom
  svccfg -s network/ipfilter:default setprop firewall_config_default/custom_policy_file = astring: "/etc/ipf/ipf.conf"
  EOH
end

pass_in = node[:ipf][:pass_in]
pass_out = node[:ipf][:pass_out]
block_in = node[:ipf][:block_in]
block_out = node[:ipf][:block_out]
ports_pass_in = node[:ipf][:ports_pass_in]
ports_pass_out = node[:ipf][:ports_pass_out]
ports_block_in = node[:ipf][:ports_block_in]
ports_block_out = node[:ipf][:port_block_out]

service "ipfilter" do
  supports :enable => true, :disable => true, :restart => true, :reload => true
  action :enable
end

template "/etc/ipf/ipf.conf" do
  source "ipf.conf.erb"
  owner "root"
  mode "0644"
  variables(:pass_in => pass_in, :pass_out => pass_out, :block_in => block_in, :block_out => block_out, :ports_pass_in => ports_pass_in, :ports_pass_out => ports_pass_out, :ports_block_in => ports_block_in, :ports_block_out => ports_block_out)
  notifies :reload, "service[ipfilter]"
end
