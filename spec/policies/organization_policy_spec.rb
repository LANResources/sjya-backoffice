require 'spec_helper'

describe OrganizationPolicy do
  subject { OrganizationPolicy.new(user, org) }

  let(:org){ create(:organization) }

  context 'for a registered user' do
    let(:user){ create(:registered_user) }

    it { should permit(:index) }
    it { should permit(:show) }
    it { should_not permit(:new) }
    it { should_not permit(:create) }
    it { should_not permit(:edit) }
    it { should_not permit(:update) }
    it { should_not permit(:destroy) }
  end

  context 'for an organization manager' do
    let(:user){ create(:organization_manager) }

    it { should permit(:index) }
    it { should permit(:show) }
    it { should_not permit(:new) }
    it { should_not permit(:create) }
    it { should_not permit(:destroy) }

    context 'for own organization' do
      let(:user){ create(:organization_manager, organization: org) }

      it { should permit(:edit) }
      it { should permit(:update) }
    end

    context 'for a different organization' do
      it { should_not permit(:edit) }
      it { should_not permit(:update) }
    end
  end

  context 'for a site manager' do
    let(:user){ create(:site_manager) }

    it { should permit(:index) }
    it { should permit(:show) }
    it { should permit(:new) }
    it { should permit(:create) }
    it { should permit(:edit) }
    it { should permit(:update) }
    it { should_not permit(:destroy) }
  end

  context 'for an administrator' do
    let(:user){ create(:administrator) }

    it { should permit(:index) }
    it { should permit(:show) }
    it { should permit(:new) }
    it { should permit(:create) }
    it { should permit(:edit) }
    it { should permit(:update) }
    it { should permit(:destroy) }
  end
end
