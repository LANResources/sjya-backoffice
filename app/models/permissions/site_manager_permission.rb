module Permissions
  class SiteManagerPermission < OrganizationManagerPermission
    def initialize(user)
      super(user)

      allow :organizations, [:index, :show, :new, :create, :edit, :update]
    end
  end
end
