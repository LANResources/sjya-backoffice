require 'spec_helper'

describe UserPolicy do
  subject { UserPolicy.new(user, other_user) }

  let(:other_user){ create(:contact) }

  context 'for a registered user' do
    let(:user){ create(:registered_user) }

    it { should permit(:index) }
    it { should permit(:show) }
    it { should_not permit(:new) }
    it { should_not permit(:create) }
    it { should_not permit(:edit) }
    it { should_not permit(:update) }
    it { should_not permit(:destroy) }

    context 'on self' do
      let(:other_user){ user }

      it { should permit(:edit) }
      it { should permit(:update) }
    end
  end

  context 'for an organization manager' do
    let(:user){ create(:organization_manager) }

    it { should permit(:index) }
    it { should permit(:show) }
    it { should permit(:new) }

    context 'on self' do
      let(:other_user){ user }

      it { should permit(:edit) }
      it { should permit(:update) }
    end

    context 'on a contact' do
      let(:other_user){ create(:contact) }

      context 'in same organization' do
        let(:other_user){ create(:contact, organization: user.organization) }

        it { should permit(:create) }
        it { should permit(:edit) }
        it { should permit(:update) }
        it { should permit(:destroy) }
      end

      context 'in a different organization' do
        it { should_not permit(:create) }
        it { should_not permit(:edit) }
        it { should_not permit(:update) }
        it { should_not permit(:destroy) }
      end
    end

    context 'on a registered user' do
      let(:other_user){ create(:registered_user) }

      context 'in same organization' do
        let(:other_user){ create(:registered_user, organization: user.organization) }

        it { should permit(:create) }
        it { should permit(:edit) }
        it { should permit(:update) }
        it { should permit(:destroy) }
      end

      context 'in a different organization' do
        it { should_not permit(:create) }
        it { should_not permit(:edit) }
        it { should_not permit(:update) }
        it { should_not permit(:destroy) }
      end
    end

    context 'on another organization manager' do
      let(:other_user){ create(:organization_manager) }

      it { should_not permit(:create) }
      it { should_not permit(:edit) }
      it { should_not permit(:update) }
      it { should_not permit(:destroy) }
    end

    context 'on a site manager' do
      let(:other_user){ create(:site_manager) }

      it { should_not permit(:create) }
      it { should_not permit(:edit) }
      it { should_not permit(:update) }
      it { should_not permit(:destroy) }
    end

    context 'on an administrator' do
      let(:other_user){ create(:administrator) }

      it { should_not permit(:create) }
      it { should_not permit(:edit) }
      it { should_not permit(:update) }
      it { should_not permit(:destroy) }
    end
  end

  context 'for a site manager' do
    let(:user){ create(:site_manager) }

    it { should permit(:index) }
    it { should permit(:show) }
    it { should permit(:new) }

    context 'on self' do
      let(:other_user){ user }

      it { should permit(:edit) }
      it { should permit(:update) }
    end

    context 'on a contact' do
      let(:other_user){ create(:contact) }

      it { should permit(:create) }
      it { should permit(:edit) }
      it { should permit(:update) }
      it { should permit(:destroy) }
    end

    context 'on a registered user' do
      let(:other_user){ create(:registered_user) }

      it { should permit(:create) }
      it { should permit(:edit) }
      it { should permit(:update) }
      it { should permit(:destroy) }
    end

    context 'on an organization manager' do
      let(:other_user){ create(:organization_manager) }

      it { should permit(:create) }
      it { should permit(:edit) }
      it { should permit(:update) }
      it { should permit(:destroy) }
    end

    context 'on another site manager' do
      let(:other_user){ create(:site_manager) }

      it { should permit(:create) }
      it { should_not permit(:edit) }
      it { should_not permit(:update) }
      it { should_not permit(:destroy) }
    end

    context 'on an administrator' do
      let(:other_user){ create(:administrator) }

      it { should_not permit(:create) }
      it { should_not permit(:edit) }
      it { should_not permit(:update) }
      it { should_not permit(:destroy) }
    end
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

    context 'on self' do
      let(:other_user){ user }

      it { should permit(:edit) }
      it { should permit(:update) }
      it { should_not permit(:destroy) }
    end

    context 'on another administrator' do
      let(:other_user){ create(:administrator) }

      it { should_not permit(:edit) }
      it { should_not permit(:update) }
      it { should_not permit(:destroy) }
    end
  end
end
