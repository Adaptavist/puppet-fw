require 'spec_helper'
 
on_true = true 
on_false = false

describe 'fw::post', :type => 'class' do
    
  context "With fw_on true it should create fw resource with 999 drop all" do 
    let(:params){{:fw_on => on_true}}
    it do
      should contain_firewall('999 drop all').with(
        'proto'   => 'all',
        'action'  => 'drop',
        'before'  => nil,
        )
    end
  end  

  context "With fw_on false it should create fw resource with 999 accept all" do 
    let(:params){{:fw_on => on_false}}
    it do
      should contain_firewall('999 accept all').with(
        'proto'   => 'all',
        'action'  => 'accept',
        'before'  => nil,
        )
    end
  end  

end
