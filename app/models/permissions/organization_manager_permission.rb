module Permissions
  class OrganizationManagerPermission < RegisteredUserPermission
    def initialize(user)
      super(user)

      # Users
      allow :users, [:index, :show, :new, :create, :edit, :update, :destroy]
      allow_param :user, [:role, :status]

      # Invites
      allow :invites, [:create, :destroy]

      # Organizations
      allow :organizations, [:index, :show]
      allow :organizations, [:edit, :update] do |other_organization|
        user.organization == other_organization
      end
      allow_param :organizations, [:name, :logo]
    end
  end
end
