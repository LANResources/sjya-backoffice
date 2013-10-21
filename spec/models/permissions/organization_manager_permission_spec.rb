require 'spec_helper'

describe Permissions::OrganizationManagerPermission do
  let(:user){ create(:registered_user, role: 'organization_manager') }
  subject { Permissions.permission_for(user) }

  it 'allows sessions' do
    should allow_page(:sessions, :new)
    should allow_page(:sessions, :create)
    should allow_page(:sessions, :destroy)
  end

  it 'allows static pages' do
    should allow_page(:static_pages, :about)
  end
end
