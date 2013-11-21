require 'spec_helper'

describe Permissions::OrganizationManagerPermission do
  let(:org){ create(:organization) }
  let(:user){ create(:registered_user, role: 'organization_manager', organization: org) }
  let(:other_user){ create(:registered_user, role: 'organization_manager', organization: org) }
  let(:site_manager){ create(:registered_user, role: 'site_manager', organization: org) }
  let(:contact){ create(:contact, organization: org) }
  subject { Permissions.permission_for(user) }

  it 'allows sessions' do
    should allow_page(:sessions, :new)
    should allow_page(:sessions, :create)
    should allow_page(:sessions, :destroy)
  end

  it 'allows invites' do
    should allow_page(:invites, :create)
    should allow_page(:invites, :edit, user)
    should_not allow_page(:invites, :edit, other_user)
    should allow_page(:invites, :update, user)
    should_not allow_page(:invites, :update, other_user)
    should allow_page(:invites, :destroy)
  end

  it 'allows users' do
    should allow_page(:users, :index)
    should allow_page(:users, :show)
    should allow_page(:users, :new)
    should allow_page(:users, :create)

    should allow_page(:users, :edit, user)
    should_not allow_page(:users, :edit, other_user)
    should_not allow_page(:users, :edit, site_manager)
    should allow_page(:users, :edit, contact)

    should allow_page(:users, :update, user)
    should_not allow_page(:users, :update, other_user)
    should_not allow_page(:users, :update, site_manager)
    should allow_page(:users, :update, contact)

    should_not allow_page(:users, :destroy, user)
    should_not allow_page(:users, :destroy, other_user)
    should_not allow_page(:users, :destroy, site_manager)
    should allow_page(:users, :destroy, contact)

    should allow_param(:user, :first_name)
    should allow_param(:user, :last_name)
    should allow_param(:user, :email)
    should allow_param(:user, :password)
    should allow_param(:user, :password_confirmation)
    should allow_param(:user, :title)
    should allow_param(:user, :phone)
    should allow_param(:user, :address)
    should allow_param(:user, :city)
    should allow_param(:user, :state)
    should allow_param(:user, :zipcode)
    should allow_param(:user, :avatar)
    should allow_param(:user, :role)
    should_not allow_param(:user, :invite_token)
    should_not allow_param(:user, :invited_at)
    should_not allow_param(:user, :invited_by)
  end

  it 'allows organizations' do
    should allow_page(:organizations, :index)
    should allow_page(:organizations, :show)
    should_not allow_page(:organizations, :new)
    should_not allow_page(:organizations, :create)
    should_not allow_page(:organizations, :edit)
    should allow_page(:organizations, :edit, user.organization)
    should_not allow_page(:organizations, :update)
    should allow_page(:organizations, :update, user.organization)
    should_not allow_page(:organizations, :destroy)
    should allow_param(:organizations, :name)
    should allow_param(:organizations, :logo)
  end

  it 'allows static pages' do
    should allow_page(:static_pages, :about)
  end
end
