module Permissions
  class RegisteredUserPermission < InvitedUserPermission
    def initialize(user)
      super(user)
      # Static Pages
      allow :static_pages, :about

      # Users
      allow :users, [:index, :show]
      allow :users, [:edit, :update] do |other_user|
        other_user == user
      end
      allow_param :user, [:first_name, :last_name, :email, :password, :password_confirmation,
                          :title, :phone, :address, :city, :state, :zipcode, :avatar]

      # Organizations
      allow :organizations, [:index, :show]
    end
  end
end
