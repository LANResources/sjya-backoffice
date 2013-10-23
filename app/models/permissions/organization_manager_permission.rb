module Permissions
  class OrganizationManagerPermission < RegisteredUserPermission
    def initialize(user)
      super(user)
      allow :users, [:index, :show, :new, :create, :edit, :update, :destroy]
      allow_param :user, [:role, :status]
      allow :invites, [:create, :destroy]
    end
  end
end
