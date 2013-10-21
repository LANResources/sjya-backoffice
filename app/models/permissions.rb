module Permissions

  def self.permission_for(user)
    if user.nil? || user.contact?
      NullPermission.new
    else
      if user.administrator?
        AdministratorPermission.new(user)
      elsif user.site_manager?
        SiteManagerPermission.new(user)
      elsif user.organization_manager?
        OrganizationManagerPermission.new(user)
      elsif user.registered_user?
        RegisteredUserPermission.new(user)
      elsif user.invited_user?
        InvitedUserPermission.new(user)
      else
        NullPermission.new
      end
    end
  end
end
