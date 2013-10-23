require 'spec_helper'

describe Permissions::NullPermission do
  subject { Permissions.permission_for(nil) }

  it 'allows sessions' do
    should allow_page(:sessions, :new)
    should allow_page(:sessions, :create)
    should allow_page(:sessions, :destroy)
  end

  it 'allows invites' do
    should_not allow_page(:invites, :create)
    should allow_page(:invites, :edit)
    should_not allow_page(:invites, :update)
    should_not allow_page(:invites, :destroy)
  end

  it 'allows users' do
    should_not allow_page(:users, :index)
    should_not allow_page(:users, :show)
    should_not allow_page(:users, :new)
    should_not allow_page(:users, :create)
    should_not allow_page(:users, :edit)
    should_not allow_page(:users, :update)
    should_not allow_page(:users, :destroy)
    should_not allow_param(:users, :first_name)
    should_not allow_param(:users, :last_name)
    should_not allow_param(:users, :email)
    should_not allow_param(:users, :password)
    should_not allow_param(:users, :password_confirmation)
    should_not allow_param(:users, :title)
    should_not allow_param(:users, :phone)
    should_not allow_param(:users, :address)
    should_not allow_param(:users, :city)
    should_not allow_param(:users, :state)
    should_not allow_param(:users, :zipcode)
    should_not allow_param(:users, :avatar)
    should_not allow_param(:users, :role)
    should_not allow_param(:users, :status)
    should_not allow_param(:users, :invite_token)
    should_not allow_param(:users, :invited_by)
    should_not allow_param(:users, :invited_at)
  end

  it 'allows static pages' do
    should_not allow_page(:static_pages, :about)
  end
end
