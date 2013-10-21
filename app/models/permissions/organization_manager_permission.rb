module Permissions
  class OrganizationManagerPermission < RegisteredUserPermission
    def initialize(user)
      super(user)
    end
  end
end
