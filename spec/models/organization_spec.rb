require 'spec_helper'

describe Organization do
  let(:org) { build(:organization) }

  subject { org }

  it 'is valid with valid attributes' do
    org.should be_valid
  end

  describe '#name' do
    it { should respond_to(:name) }

    it 'is required' do
      org.name = nil
      org.should_not be_valid
    end
  end

  describe '#logo' do
    it { should respond_to(:logo) }
  end
end
