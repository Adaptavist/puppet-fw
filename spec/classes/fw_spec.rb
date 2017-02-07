require 'spec_helper'
 
on_ok = true 
chains_ok = []
rules_ok  = {}

on_fail = "not_bool"
chains_fail = "not_array"
rules_fail  = "not_hash"

rules = {
    '001 accept all icmp' =>
      {
      'chain' => 'INPUT',
      'proto' => 'icmp',
      'action' => 'accept',
      }
    }

describe 'fw', :type => 'class' do
  
  let(:facts){{:kernel => 'Linux'}}

  context "With default parameters it should create resource firewall and run pre, post and custom fw" do 
    it do
      should contain_class('fw::pre')
      should contain_class('fw::custom')
      should contain_resources('firewall')
      should contain_class('fw::post')
    end
  end  

  context "With rules set, it should create firewall resources" do 
    let(:params){{ :rules => rules}}
    it do
      should contain_class('fw::pre')
      should contain_class('fw::custom')
      should contain_firewall('001 accept all icmp').with(
        'chain' => 'INPUT',
        'proto' => 'icmp',
        'action' => 'accept',
        )
      should contain_class('fw::post')
    end
  end  

  context "should validate $on param and fail if not bool" do
    let(:params){{:on => on_fail}}
    it { expect { should contain_class('fw::pre') }.to raise_error(Puppet::Error) }
  end

  context "should validate $on param and pass if boolean" do
    let(:params){{:on => on_ok}}
    it { should contain_class('fw::pre') }
  end

  context "should validate $chains param and fail if not array" do
    let(:params){{:chains => chains_fail}}
    it { expect { should contain_class('fw::pre') }.to raise_error(Puppet::Error) }
  end

  context "should validate $chains param and pass if array" do
    let(:params){{:chains => chains_ok}}
    it { should contain_class('fw::pre') }
  end

  context "should validate $rules param and fail if not hash" do
    let(:params){{:rules => rules_fail}}
    it { expect { should contain_class('fw::pre') }.to raise_error(Puppet::Error) }
  end

  context "should validate $rules param and pass if hash" do
    let(:params){{:rules => rules_ok}}
    it { should contain_class('fw::pre') }
  end
end
