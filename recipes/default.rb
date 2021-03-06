#
# Cookbook Name:: chef-varnish
# Recipe:: default
#
# Copyright 2012, Alistair Stead
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

require 'shellwords'

node.default['varnish']['repository'] = "varnishcache/varnish#{node['varnish']['version'].delete('.')}"
packagecloud_repo (node['varnish']['repository']).to_s do
  type node['varnish']['package_type']
end

package 'varnish' do
  action :install
end

include_recipe 'chef-varnish::geoip' if node['varnish']['GeoIP_enabled']
include_recipe 'chef-varnish::geoip2' if node['varnish']['GeoIP2']['enabled']

template "#{node['varnish']['config_dir']}/default.vcl" do
  source 'default.vcl.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables(
    params: node['varnish']
  )
end

template node['varnish']['daemon_config'] do
  source 'varnish.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables(
    params: node['varnish']
  )
end

file node['varnish']['VARNISH_SECRET_FILE'] do
  owner 'root'
  group 'root'
  mode 0600
  content node['varnish']['VARNISH_SECRET']
  only_if { node['varnish']['VARNISH_SECRET'] != '' }
  notifies :restart, 'service[varnish]', :delayed
end

service 'varnish' do
  supports restart: true, reload: true
  action [:enable, :start]
end

service 'varnishlog' do
  supports restart: true, reload: true
  action [:enable, :start]
  only_if { node['varnish']['use_varnishlog_service'] }
end
