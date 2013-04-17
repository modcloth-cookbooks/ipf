#
# Cookbook Name:: ipf
# Recipe:: default
#
# Copyright 2013, ModCloth, Inc.
# Author: ModCloth, Inc.
# Author: sawanoboriyu@higanworks.com
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

service "ipfilter" do
  supports :enable => true, :disable => true, :restart => true, :reload => true
  action :enable
end

if node['ipf']['use_metadata']
  add_pass_in = SmartMachine::Metadata.from_metadata(node['ipf']['key_metadata'])
  if add_pass_in
    new_pass_in = node['ipf']['pass_in'] + add_pass_in.chomp.split(",")
    new_pass_in.uniq!
    node.set['ipf']['pass_in'] = new_pass_in
  end
end


case node['ipf']['rule_type']
when "string"
  template "/etc/ipf/ipf.conf" do
    source "ipf.conf.erb"
    owner "root"
    mode "0644"
    variables node[:ipf]
    notifies :reload, "service[ipfilter]"
  end
when "array"
  template "/etc/ipf/ipf.conf" do
    source "ipf_array.conf.erb"
    owner "root"
    mode "0644"
    variables node[:ipf]
    notifies :reload, "service[ipfilter]"
  end
end
