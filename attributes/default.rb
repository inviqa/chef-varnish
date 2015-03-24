case platform_family
  when 'debian', 'ubuntu'
    default['varnish']['daemon_config'] = "/etc/default/varnish"
    default['varnish']['dev_package'] = 'libvarnish-dev'
  else
    default['varnish']['daemon_config'] = "/etc/sysconfig/varnish"
    default['varnish']['dev_package'] = 'varnish-libs-devel'
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
default['varnish']['release_rpm'] = 'http://repo.varnish-cache.org/redhat/varnish-3.0/el5/noarch/varnish-release/varnish-release-3.0-1.noarch.rpm'
default['varnish']['custom_parameters'] = {}
default['varnish']['nagios_plugin_source'] = 'http://repo.varnish-cache.org/source/varnish-nagios-1.1.tar.gz'
default['varnish']['nagios_plugin_dir'] = '/usr/lib64/nagios/plugins/'
