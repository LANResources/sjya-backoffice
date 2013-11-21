require 'spec_helper'

describe InvitePolicy do
  subject { InvitePolicy.new(user, invited_user) }

  let(:invited_user){ create(:invited_registered_user) }

  context 'for the invited user' do
    let(:user){ invited_user }

    it { should permit(:edit) }
    it { should permit(:update) }
    it { should_not permit(:create) }
    it { should_not permit(:destroy) }
  end

  context 'for a different invited user' do
    let(:user){ create(:invited_registered_user) }

    it { should_not permit(:edit) }
    it { should_not permit(:update) }
    it { should_not permit(:create) }
    it { should_not permit(:destroy) }
  end

  context 'for a registered user' do
    let(:user){ create(:registered_user) }

    it { should_not permit(:edit) }
    it { should_not permit(:update) }
    it { should_not permit(:create) }
    it { should_not permit(:destroy) }
  end

  context 'for an organization manager' do
    let(:user){ create(:organization_manager) }

    it { should_not permit(:edit) }
    it { should_not permit(:update) }
    it { should permit(:create) }
    it { should permit(:destroy) }
  end

  context 'for a site manager' do
    let(:user){ create(:site_manager) }

    it { should_not permit(:edit) }
    it { should_not permit(:update) }
    it { should permit(:create) }
    it { should permit(:destroy) }
  end

  context 'for an administrator' do
    let(:user){ create(:administrator) }

    it { should_not permit(:edit) }
    it { should_not permit(:update) }
    it { should permit(:create) }
    it { should permit(:destroy) }
  end
end
