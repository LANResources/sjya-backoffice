require 'spec_helper'

describe Permissions::SiteManagerPermission do
  let(:user){ create(:registered_user, role: 'site_manager') }
  subject { Permissions.permission_for(user) }

  it 'allows sessions' do
    should allow_page(:sessions, :new)
    should allow_page(:sessions, :create)
    should allow_page(:sessions, :destroy)
  end

  it 'allows users' do
    should allow_page(:users, :index)
    should allow_page(:users, :show)
    should allow_page(:users, :new)
    should allow_page(:users, :create)
    should allow_page(:users, :edit)
    should allow_page(:users, :update)
    should allow_page(:users, :destroy)

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
    should allow_param(:user, :status)
  end

  it 'allows static pages' do
    should allow_page(:static_pages, :about)
  end
end
