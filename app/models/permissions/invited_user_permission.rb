module Permissions
  class InvitedUserPermission < NullPermission
    def initialize(user)
      super()
      allow :invites, [:edit, :update] do |other_user|
        other_user == user
      end
      allow_param :user, [:first_name, :last_name, :email, :password, :password_confirmation,
                          :title, :phone, :address, :city, :state, :zipcode, :avatar]
    end
  end
end
