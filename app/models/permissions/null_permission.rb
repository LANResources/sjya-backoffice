module Permissions
  class NullPermission < BasePermission
    def initialize
      super()
      allow :sessions, [:new, :create, :destroy]
      allow :invites, [:edit]
    end
  end
end
