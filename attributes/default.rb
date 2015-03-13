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
default['varnish']['VARNISH_BACKEND_CONNECT_TIMEOUT'] = "2s"
default['varnish']['VARNISH_BACKEND_FIRST_BYTE_TIMEOUT'] = "5s"
default['varnish']['VARNISH_BACKEND_BETWEEN_BYTES_TIMEOUT'] = "5s"
default['varnish']['VARNISH_BACKEND_MAX_CONNECTIONS'] = 400
default['varnish']['VARNISH_PROBE_URL'] = "/favicon.ico"
default['varnish']['VARNISH_PROBE_INTERVAL'] = "15s"
default['varnish']['VARNISH_PROBE_TIMEOUT'] = "1s"
default['varnish']['VARNISH_PROBE_WINDOW'] = 5
default['varnish']['VARNISH_PROBE_THRESHOLD'] = 2
default['varnish']['VARNISH_PROBE_EXPECTED_RESPONSE'] = 200
default['varnish']['VARNISH_ADMIN_LISTEN_ADDRESS'] = "127.0.0.1"
default['varnish']['VARNISH_ADMIN_LISTEN_PORT'] = 6082
default['varnish']['VARNISH_SECRET_FILE'] = "/etc/varnish/secret"
default['varnish']['VARNISH_MIN_THREADS'] = 100
default['varnish']['VARNISH_MAX_THREADS'] = 1000
default['varnish']['VARNISH_THREAD_POOL_MIN'] = 400
default['varnish']['VARNISH_THREAD_TIMEOUT'] = 120
default['varnish']['VARNISH_STORAGE_FILE'] = "/var/lib/varnish/varnish_storage.bin"
default['varnish']['VARNISH_STORAGE_SIZE'] = "5G"
default['varnish']['VARNISH_STORAGE'] = "malloc" # file | malloc | persistent
default['varnish']['VARNISH_TTL'] = 120
default['varnish']['VARNISH_WORKING_DIR'] = ''
default['varnish']['GeoIP_enabled'] = false
default['varnish']['release_rpm'] = 'http://repo.varnish-cache.org/redhat/varnish-3.0/el5/noarch/varnish-release/varnish-release-3.0-1.noarch.rpm'
default['varnish']['custom_parameters'] = {}