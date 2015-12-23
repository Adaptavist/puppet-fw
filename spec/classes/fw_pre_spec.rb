require 'spec_helper'
 
chains = ['service_hosts', 'management_hosts']
suffix = ':filter:IPv4'

describe 'fw::pre', :type => 'class' do
  
  context "Should inherit fw" do
    it do
      should contain_fw
    end
  end  

  context "Should set reguire and purge to firewall" do
    it do
      should contain_resources('firewall').with(
        'require' => nil,
        'purge' => 'true',
        ).that_comes_before('fw::create_chains[fw::create_chains]')
    end
  end  

  context "should create chains using define with []default" do 
    it do
      should contain_fw__create_chains('fw::create_chains').with(
        'chains'   => [],
        )
    end
  end  

  context "should create chains using define with sufixed chain" do 
    let(:params){{:fw_chains => chains}}
    
    it do
      should contain_fw__create_chains('fw::create_chains').with(
        'chains' => chains.map { |chain| "#{chain}#{suffix}" },
        )
    end
  end 

end
