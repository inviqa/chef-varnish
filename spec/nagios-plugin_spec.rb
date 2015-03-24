describe 'chef-varnish::nagios-plugin' do

  context 'when installing on any platform' do
    let (:chef_run) {
      ChefSpec::SoloRunner.new do |node|
        node.set['varnish']['nagios_plugin_source'] = 'http://example.com/file.tar.gz'
        node.set['varnish']['nagios_plugin_dir'] = '/foo'
      end.converge(described_recipe)
    }

    it 'should create the plugin executable' do
      expect(chef_run).to install_tar_package('http://example.com/file.tar.gz').with({
        prefix: '/foo',
        creates: '/foo/check_varnish'
      })
    end
  end

  context 'when installing on Ubuntu' do
    let (:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04').converge(described_recipe) }

    it 'should install the Ubuntu flavour development packages' do
      expect(chef_run).to install_package('libvarnish-dev')
    end
  end

  context 'when installing on Redhat' do
    let (:chef_run) { ChefSpec::SoloRunner.new(platform: 'redhat', version: '6.4').converge(described_recipe) }

    it 'should install the Redhat flavour development packages' do
      expect(chef_run).to install_package('varnish-libs-devel')
    end
  end

end