require 'spec_helper'

describe 'mtr' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "mtr class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('mtr::params') }
          it { is_expected.to contain_class('mtr::install').that_comes_before('mtr::config') }
          it { is_expected.to contain_class('mtr::config') }
          it { is_expected.to contain_class('mtr::service').that_subscribes_to('mtr::config') }

          it { is_expected.to contain_service('mtr') }
          it { is_expected.to contain_package('mtr').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'mtr class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { is_expected.to contain_package('mtr') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
