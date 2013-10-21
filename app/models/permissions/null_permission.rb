module Permissions
  class NullPermission < BasePermission
    def initialize
      super()
      allow :sessions, [:new, :create, :destroy]
    end
  end
end
