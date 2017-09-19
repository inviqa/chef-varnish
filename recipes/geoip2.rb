if node['varnish']['GeoIP2']['enabled']
  %w(unzip python-docutils varnish-libs-devel libmaxminddb-devel autoconf automake libtool).each do |pkg|
    package pkg do
      action :install
    end
  end

  bash 'download libgoip2 varnish module' do
    code 'wget --no-clobber --no-check-certificate '\
      '--output-document=/tmp/libvmod-geoip2.zip '\
      'https://github.com/fgsch/libvmod-geoip2/archive/master.zip'
    not_if { File.exist? '/tmp/libvmod-geoip2.zip' }
  end

  bash 'uncompress libgoip2 varnish module' do
    cwd '/tmp'
    code 'unzip libvmod-geoip2.zip'
    not_if { File.directory? '/tmp/libvmod-geoip2-master' }
  end

  bash 'prepare configuration libgoip2 varnish module' do
    cwd '/tmp/libvmod-geoip2-master'
    code './autogen.sh'
    not_if { File.exist? '/usr/lib64/varnish/vmods/libvmod_geoip2.so' }
  end

  bash 'configure building libgoip2 varnish module' do
    cwd '/tmp/libvmod-geoip2-master'
    code './configure'
    not_if { File.exist? '/usr/lib64/varnish/vmods/libvmod_geoip2.so' }
  end

  bash 'build libgoip2 varnish module' do
    cwd '/tmp/libvmod-geoip2-master'
    code 'make'
    not_if { File.exist? '/usr/lib64/varnish/vmods/libvmod_geoip2.so' }
  end

  bash 'install libgoip2 varnish module' do
    cwd '/tmp/libvmod-geoip2-master'
    code 'make install'
    not_if { File.exist? '/usr/lib64/varnish/vmods/libvmod_geoip2.so' }
  end

  template "#{node['varnish']['config_dir']}/geoip.vcl" do
    source 'geoip.vcl.erb'
    owner 'root'
    group 'root'
    mode 0644
    variables(
      varnish: node['varnish']
    )
    notifies :restart, 'service[varnish]', :delayed
  end

  bash 'download geoip2 database' do
    code 'wget --no-clobber --output-document=/tmp/GeoLite2-Country.mmdb.gz http://geolite.maxmind.com/download/geoip/database/GeoLite2-Country.mmdb.gz'
    not_if { File.exist? '/tmp/GeoLite2-Country.mmdb.gz' }
  end

  bash 'uncompress geoip2 database' do
    cwd '/tmp'
    code 'rm -f GeoLite2-Country.mmdb && gunzip GeoLite2-Country.mmdb.gz'
    not_if { File.exist? '/tmp/GeoLite2-Country.mmdb' }
  end

  bash 'move geoip2 database to the permanent location' do
    cwd '/tmp'
    code "mv GeoLite2-Country.mmdb #{node['varnish']['GeoIP2']['database_location']}"
    not_if { File.directory? '/tmp/GeoLite2-Country.mmdb.gz' }
  end
end
