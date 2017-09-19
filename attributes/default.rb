case platform_family
when 'rhel', 'fedora', 'suse'
  default['varnish']['daemon_config'] = '/etc/sysconfig/varnish'
when 'debian'
  default['varnish']['daemon_config'] = '/etc/default/varnish'
end

default['varnish']['config_dir'] = '/etc/varnish'
default['varnish']['VARNISH_VCL_CONF'] = '/etc/varnish/default.vcl'
default['varnish']['VARNISH_LISTEN_PORT'] = 6081
default['varnish']['VARNISH_BACKEND_PORT'] = 80
default['varnish']['VARNISH_BACKEND_ADDRESS'] = '127.0.0.1'
default['varnish']['VARNISH_ADMIN_LISTEN_ADDRESS'] = '127.0.0.1'
default['varnish']['VARNISH_ADMIN_LISTEN_PORT'] = 6082
default['varnish']['VARNISH_SECRET_FILE'] = '/etc/varnish/secret'
default['varnish']['VARNISH_MIN_THREADS'] = 1
default['varnish']['VARNISH_MAX_THREADS'] = 1000
default['varnish']['VARNISH_THREAD_TIMEOUT'] = 120
default['varnish']['VARNISH_STORAGE_FILE'] = '/var/lib/varnish/varnish_storage.bin'
default['varnish']['VARNISH_STORAGE_SIZE'] = '1G'
default['varnish']['VARNISH_STORAGE'] = 'malloc' # file | malloc | persistent
default['varnish']['VARNISH_TTL'] = 120
default['varnish']['VARNISH_WORKING_DIR'] = ''
default['varnish']['VARNISH_UID_SWITCH'] = true
default['varnish']['GeoIP_enabled'] = false
default['varnish']['version'] = '3.0'

default['varnish']['custom_parameters'] = {}

default['varnish']['package_type'] = if platform_family?('rhel', 'fedora', 'suse', 'amazon')
                                       'rpm'
                                     else
                                       'deb'
                                     end

default['varnish']['VARNISH_SECRET'] = ''
default['varnish']['VARNISH_SECRET_FILE'] = '/etc/varnish/secret'

default['varnish']['use_varnishlog_service'] = true

default['varnish']['GeoIP2']['enabled'] = false
default['varnish']['GeoIP2']['database_location'] = '/etc/varnish/geoipdb.mmdb'
