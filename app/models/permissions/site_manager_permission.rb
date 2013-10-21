module Permissions
  class SiteManagerPermission < OrganizationManagerPermission
    def initialize(user)
      super(user)
    end
  end
end
