require 'spec_helper'

def_title = "management_hosts"

describe 'fw::custom::helper', :type => 'define' do
    let :title do
      def_title
    end

    context "should have [] as default parameter" do
        it { should_not contain_firewallchain }
    end
    
    # context "should create firewallchains passed as parameters" do    
    # let(:params){{ :chains => chains}}
    # it do
    #     chains.each do |chain|
    #         should contain_firewallchain(chain)
    #     end
    #   end
    # end
end
