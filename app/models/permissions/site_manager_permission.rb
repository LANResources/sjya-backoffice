module Permissions
  class SiteManagerPermission < OrganizationManagerPermission
    def initialize(user)
      super(user)

      allow :organizations, [:index, :show, :new, :create, :edit, :update]

      allow :users, [:index, :show, :new, :create]
      allow :users, [:edit, :update] do |other_user|
        user == other_user || user > other_user
      end
      allow :users, :destroy do |other_user|
        user > other_user
      end
    end
  end
end
