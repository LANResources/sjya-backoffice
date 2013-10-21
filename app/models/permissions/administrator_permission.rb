module Permissions
  class AdministratorPermission < SiteManagerPermission
    def initialize(user)
      super(user)
      allow_all
    end
  end
end
