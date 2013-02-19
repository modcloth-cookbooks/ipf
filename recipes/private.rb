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

include_recipe "ipf::default"

private_ip_ranges = node[:ipf][:private_ranges]

service "ipfilter" do
  supports :enable => true, :disable => true, :restart => true, :reload => true
  action :enable
end

template "/etc/ipf/ipf.conf" do
  source "private-only-ipf.conf.erb"
  owner "root"
  mode "0644"
  variables(:private_ip_ranges => private_ip_ranges)
  notifies :reload, "service[ipfilter]"
end
