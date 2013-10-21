require 'spec_helper'

describe Permissions::AdministratorPermission do
  let(:user){ create(:registered_user, role: 'administrator') }
  subject { Permissions.permission_for(user) }

  it 'allows everything' do
    should allow_page(:anything, :here)
    should allow_param(:anything, :here)
    should allow_param(:user, :role)
  end
end
