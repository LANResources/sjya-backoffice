require 'spec_helper'

describe Permissions::RegisteredUserPermission do
  let(:user){ create(:registered_user) }
  let(:other_user){ create(:registered_user) }

  subject { Permissions.permission_for(user) }

  it 'allows sessions' do
    should allow_page(:sessions, :new)
    should allow_page(:sessions, :create)
    should allow_page(:sessions, :destroy)
  end

  it 'allows invites' do
    should_not allow_page(:invites, :create)
    should allow_page(:invites, :edit, user)
    should_not allow_page(:invites, :edit, other_user)
    should allow_page(:invites, :update, user)
    should_not allow_page(:invites, :update, other_user)
    should_not allow_page(:invites, :destroy)
  end

  it 'allows users' do
    should allow_page(:users, :index)
    should allow_page(:users, :show)
    should_not allow_page(:users, :new)
    should_not allow_page(:users, :create)
    should allow_page(:users, :edit, user)
    should_not allow_page(:users, :edit, other_user)
    should allow_page(:users, :update, user)
    should_not allow_page(:users, :update, other_user)
    should_not allow_page(:users, :destroy)

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
    should_not allow_param(:user, :role)
    should_not allow_param(:user, :status)
    should_not allow_param(:user, :invite_token)
    should_not allow_param(:user, :invited_at)
    should_not allow_param(:user, :invited_by)
  end

  it 'allows static pages' do
    should allow_page(:static_pages, :about)
  end
end
