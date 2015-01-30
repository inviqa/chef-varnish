require 'spec_helper'

describe 'chef-varnish::default' do
  context 'default run' do
    let (:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.5').converge(described_recipe) }

    it 'should accept an array of launch parameters that are empty by default' do
      expect(chef_run.node['varnish']['custom_parameters']).to eq([])
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
        .with_content(match(/-S \${VARNISH_SECRET_FILE} \\\s*-p esi_syntax=0x2 \\\s*-p cli_buffer=16384 \\\s*-s \${VARNISH_STORAGE}/m))
    end
  end
end
