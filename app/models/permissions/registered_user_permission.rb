module Permissions
  class RegisteredUserPermission < InvitedUserPermission
    def initialize(user)
      super(user)
      allow :static_pages, :about
      allow :users, [:index, :show]
      allow :users, [:edit, :update] do |other_user|
        other_user == user
      end
    end
  end
end
