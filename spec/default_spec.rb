require 'spec_helper'

describe 'chef-varnish::default' do
  context 'default run' do
    let (:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.5').converge(described_recipe) }

    it 'should accept an array of launch parameters that are empty by default' do
      expect(chef_run.node['varnish']['custom_parameters']).to eq({})
    end

    it 'should use the launch parameters in the daemon options' do
      expect(chef_run).to render_file('/etc/sysconfig/varnish')
        .with_content(match(/-S \${VARNISH_SECRET_FILE} \\\s*-s \${VARNISH_STORAGE}/m))
    end
  end

  context 'with launch parameters' do
    let (:chef_run) {
      ChefSpec::SoloRunner.new(platform: 'centos', version: '6.5') do |node|
        node.set['varnish']['custom_parameters'] = {
          "esi_syntax" => "0x2",
          "cli_buffer" => "16384"
        }
      end.converge(described_recipe)
    }

    it 'should use the launch parameters in the daemon options' do
      expect(chef_run).to render_file('/etc/sysconfig/varnish')
        .with_content(match(/-s \${VARNISH_STORAGE} \\\s*-p esi_syntax=0x2 \\\s*-p cli_buffer=16384/m))
    end
  end

  context 'ubuntu default run' do
    let (:chef_run) {
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04').converge(described_recipe)
    }

    it 'should install the varnish apt repository' do
      expect(chef_run).to add_apt_repository('varnish-cache.org').with({
        :components => ['varnish-3.0']
      })
    end
  end
end
