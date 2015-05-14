case platform_family
when "rhel", "fedora", "suse"
  default['varnish']['daemon_config'] = "/etc/sysconfig/varnish"
when "debian"
  default['varnish']['daemon_config'] = "/etc/default/varnish"
end

default['varnish']['config_dir'] = "/etc/varnish"
default['varnish']['VARNISH_VCL_CONF'] = "/etc/varnish/default.vcl"
default['varnish']['VARNISH_LISTEN_PORT'] = 6081
default['varnish']['VARNISH_BACKEND_PORT'] = 80
default['varnish']['VARNISH_BACKEND_ADDRESS'] = "127.0.0.1"
default['varnish']['VARNISH_ADMIN_LISTEN_ADDRESS'] = "127.0.0.1"
default['varnish']['VARNISH_ADMIN_LISTEN_PORT'] = 6082
default['varnish']['VARNISH_SECRET_FILE'] = "/etc/varnish/secret"
default['varnish']['VARNISH_MIN_THREADS'] = 1
default['varnish']['VARNISH_MAX_THREADS'] = 1000
default['varnish']['VARNISH_THREAD_TIMEOUT'] = 120
default['varnish']['VARNISH_STORAGE_FILE'] = "/var/lib/varnish/varnish_storage.bin"
default['varnish']['VARNISH_STORAGE_SIZE'] = "1G"
default['varnish']['VARNISH_STORAGE'] = "malloc" # file | malloc | persistent
default['varnish']['VARNISH_TTL'] = 120
default['varnish']['VARNISH_WORKING_DIR'] = ''
default['varnish']['GeoIP_enabled'] = false
default['varnish']['version'] = '3.0'

default['varnish']['release_elversion'] = if platform_family?('redhat')
  node['platform_version'].to_i
else
  5
end

default['varnish']['release_baseurl'] = "http://repo.varnish-cache.org/redhat/varnish-#{node['varnish']['version']}/el#{node['varnish']['release_elversion']}/$basearch/"
default['varnish']['custom_parameters'] = {}
