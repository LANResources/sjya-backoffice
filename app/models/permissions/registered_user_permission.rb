module Permissions
  class RegisteredUserPermission < InvitedUserPermission
    def initialize(user)
      super(user)
      allow :static_pages, :about
    end
  end
end
