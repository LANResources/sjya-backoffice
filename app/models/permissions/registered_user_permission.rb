module Permissions
  class RegisteredUserPermission < InvitedUserPermission
    def initialize(user)
      super(user)
      allow :static_pages, :about
      allow :users, [:index, :show]
      allow :users, [:edit, :update] do |other_user|
        other_user == user
      end
      allow_param :user, [:first_name, :last_name, :email, :password, :password_confirmation,
                          :title, :phone, :address, :city, :state, :zipcode, :avatar]
    end
  end
end
