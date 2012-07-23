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


if platform?("redhat", "centos", "fedora")
  include_recipe "yum"
  bash "varnish-cache.org" do
    user "root"
    code <<-EOH
    rpm --nosignature -i http://repo.varnish-cache.org/redhat/varnish-3.0/el5/noarch/varnish-release-3.0-1.noarch.rpm
    yum -y update
    EOH
  end
end

if platform?("ubuntu")
  include_recipe "apt"
  apt_repository "varnish-cache.org" do
    uri "http://repo.varnish-cache.org/ubuntu/"
    distribution node['lsb']['codename']
    components ["main"]
    key "http://repo.varnish-cache.org/debian/GPG-key.txt"
    deb_src true
    notifies :run, resources(:execute => "apt-get update"), :immediately
  end
end

if platform?("debian")
  apt_repository "varnish-cache.org" do
    uri "http://repo.varnish-cache.org/debian/"
    distribution node['lsb']['codename']
    components ["main"]
    key "http://repo.varnish-cache.org/debian/GPG-key.txt"
    deb_src true
    notifies :run, resources(:execute => "apt-get update"), :immediately
  end
end

package "varnish" do
  action :install
end

template "#{node[:varnish][:config_dir]}default.vcl" do
  source "default.vcl.erb"
  owner "root"
  group "root"
  mode 0644
end

template "#{node[:varnish][:daemon_config]}" do
  source "varnish.erb"
  owner "root"
  group "root"
  mode 0644
end


