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

if platform_family?('rhel', 'fedora', 'suse')
  packagecloud_repo "#{node['varnish']['repository']}" do
    type "rpm"
  end
end

if platform_family?("debian")
  packagecloud_repo "#{node['varnish']['repository']}" do
    type "deb"
  end
end

pkgs = %w{ varnish }

if platform_family?('rhel', 'fedora', 'suse') && node['varnish']['release_rpm']
  pkgs.unshift('varnish-release')
end

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

if node['varnish']['GeoIP_enabled']
  include_recipe 'chef-varnish::geoip'
end

template "#{node['varnish']['config_dir']}/default.vcl" do
  source 'default.vcl.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables(
    :params => node['varnish']
  )
end

template node['varnish']['daemon_config'] do
  source 'varnish.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables(
    :params => node['varnish']
  )
end

service 'varnish' do
  supports :restart => true, :reload => true
  action [ :enable, :start ]
end

service 'varnishlog' do
  supports :restart => true, :reload => true
  action [ :enable, :start ]
end
