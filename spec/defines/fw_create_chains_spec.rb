require 'spec_helper'

def_title = "chain"

chains = ['management_hosts:filter:IPv4', 'service_hosts:filter:IPv4']

describe 'fw::create_chains', :type => 'define' do
    let :title do
      def_title
    end

    context "should have [] as default parameter" do
        it { should_not contain_class('firewallchain') }
    end
    
    context "should create firewallchains passed as parameters" do    
    let(:params){{ :chains => chains}}
    it do
        chains.each do |chain|
            should contain_firewallchain(chain)
        end
      end
    end
end
