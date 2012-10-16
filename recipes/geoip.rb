
package "GeoIP-devel"
package "wget"


if File.exists?("/etc/varnish/geoip.vcl")
    log("varnish geoip extension is already installed") { level :info }
else

    git '/usr/src/varnish-geoip' do
        repository 'git://github.com/svalaskevicius/varnish-geoip.git'
        reference 'develop'
    end

    bash "download geolite data" do
        cwd "/tmp"
        code <<=EOH
            rm -f "GeoIP.dat.gz" && wget "http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz" || exit 1
            zcat "GeoIP.dat.gz" > "/usr/share/GeoIP/GeoIP.dat"
        EOH
        not if "test -f /usr/share/GeoIP/GeoIP.dat"
    end

    bash "compile varnish geoip ext" do
      cwd "/usr/src/varnish-geoip"
      code <<-EOH
        make && test $(./geoip 141.0.34.138) = GB && cp geoip.vcl /etc/varnish/geoip.vcl
      EOH
    end

end

