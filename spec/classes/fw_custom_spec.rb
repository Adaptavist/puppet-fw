require 'spec_helper'
 
fw_chains = ['service_hosts', 'management_hosts']

describe 'fw::custom', :type => 'class' do
  
  context "Should inherit fw" do
    it do
      should contain_class('fw')
    end
  end  

  context "Should create define fw_custom_helper with fw_chains" do
    let(:params){{:fw_chains => fw_chains}}
    it do
      fw_chains.each do |chain|
        should contain_fw__custom__helper(chain)
      end
    end
  end  

end
