
package 'GeoIP-devel'
package 'wget'

geolite_url = 'http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz'

bash 'download geolite data' do
  cwd '/tmp'
  code <<-EOH
    rm -f "GeoIP.dat.gz" && wget "#{geolite_url}" || exit 1
    mkdir -p "/usr/share/GeoIP/" && zcat "GeoIP.dat.gz" > "/usr/share/GeoIP/GeoIP.dat"
  EOH
  not_if 'test -f /usr/share/GeoIP/GeoIP.dat'
end

if File.exist?('/etc/varnish/geoip.vcl')
  log('varnish geoip extension is already installed') { level :info }
else

  git '/usr/src/varnish-geoip' do
    repository 'https://github.com/svalaskevicius/varnish-geoip.git'
    reference 'develop'
  end

  bash 'compile varnish geoip ext' do
    cwd '/usr/src/varnish-geoip'
    code <<-EOH
      make && test $(./geoip 213.236.208.22) = NO && cp geoip.vcl /etc/varnish/geoip.vcl
EOH
  end

end
