require 'spec_helper'

describe Parker do
  describe '::VERSION' do
    subject { Parker::VERSION }
    it { should be_an_instance_of String }
    it { should match(/\d+\.\d+\.\d+(?:\-[a-zA-Z0-9_\.\-]+)?/) }
  end
end
