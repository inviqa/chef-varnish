#
# Cookbook Name:: chef-varnish
# Recipe:: nagios-plugin
#
# Copyright 2015, Inviqa
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

include_recipe 'build-essential'

package node['varnish']['dev_package'] do
  action :install
end

directory node['varnish']['nagios_plugin_dir'] do
  recursive true
  not_if { Dir.exists?(node['varnish']['nagios_plugin_dir']) }
end

tar_package node['varnish']['nagios_plugin_source'] do
  prefix node['varnish']['nagios_plugin_dir']
  creates "#{node['varnish']['nagios_plugin_dir']}/check_varnish"
end
