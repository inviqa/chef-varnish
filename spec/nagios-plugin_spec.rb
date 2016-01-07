describe 'chef-varnish::nagios-plugin' do

  context 'when installing on any platform' do
    let (:chef_run) {
      ChefSpec::SoloRunner.new do |node|
        node.set['varnish']['nagios_plugin_source'] = 'http://example.com/file.tar.gz'
        node.set['varnish']['nagios_plugin_dir'] = '/foo'
      end.converge(described_recipe)
    }

    it 'should ensure build tools are installed' do
      expect(chef_run).to include_recipe('build-essential::default')
    end

    it 'should create the plugin executable' do
      expect(chef_run).to install_tar_package('http://example.com/file.tar.gz').with({
        prefix: '/foo',
        creates: '/foo/check_varnish'
      })
    end
  end

  context 'when plugin directory does not exist' do
    let (:chef_run) {
      ChefSpec::SoloRunner.new do |node|
        node.set['varnish']['nagios_plugin_dir'] = '/foo'
      end.converge(described_recipe)
    }

    before {
      allow(Dir).to receive(:exists?).and_call_original
      allow(Dir).to receive(:exists?).with('/foo').and_return(false)
    }

    it 'should create the plugin directory' do
      expect(chef_run).to create_directory('/foo').with({recursive: true})
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
