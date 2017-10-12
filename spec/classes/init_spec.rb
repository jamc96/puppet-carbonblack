require 'spec_helper'
describe 'carbonblack' do
  context 'with default values for all parameters' do
    it { should contain_class('carbonblack') }
  end
end
