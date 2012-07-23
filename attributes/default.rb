case platform
when "redhat", "centos", "fedora"
  set[:varnish][:daemon_config] = "/etc/sysconfig/varnish"
when "debian","ubuntu"
  set[:varnish][:daemon_config] = "/etc/default/varnish"
end

set[:varnish][:config_dir] = "/etc/varnish"
set[:varnish][:VARNISH_VCL_CONF] = "/etc/varnish/default.vcl"
set[:varnish][:VARNISH_LISTEN_PORT] = 6081
set[:varnish][:VARNISH_ADMIN_LISTEN_ADDRESS] = "127.0.0.1"
set[:varnish][:VARNISH_ADMIN_LISTEN_PORT] = 6082
set[:varnish][:VARNISH_SECRET_FILE] = "/etc/varnish/secret"
set[:varnish][:VARNISH_MIN_THREADS] = 1
set[:varnish][:VARNISH_MAX_THREADS] = 1000
set[:varnish][:VARNISH_THREAD_TIMEOUT] = 120
set[:varnish][:VARNISH_STORAGE_FILE] = "/var/lib/varnish/varnish_storage.bin"
set[:varnish][:VARNISH_STORAGE_SIZE] = "1G"
set[:varnish][:VARNISH_STORAGE] = "malloc" # file | malloc | persistent
set[:varnish][:VARNISH_TTL] = 120

