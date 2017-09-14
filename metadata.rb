maintainer       'Alistair Stead'
maintainer_email 'alistair@inviqa.com'
license          'Apache 2.0'
description      'Installs/Configures chef-varnish'
name             'chef-varnish'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '2.0.0'

depends 'apt'
depends 'yum'

depends 'packagecloud', '~> 0.3.0'

%w(redhat centos scientific fedora debian ubuntu arch freebsd amazon).each do |os|
  supports os
end

recipe 'chef-varnish', 'Installs and Configures Varnish 3.*'
