module Permissions

  def self.permission_for(user)
    if user.nil? || user.contact?
      NullPermission.new
    elsif user.invited?
      InvitedUserPermission.new(user)
    elsif user.administrator?
      AdministratorPermission.new(user)
    elsif user.site_manager?
      SiteManagerPermission.new(user)
    elsif user.organization_manager?
      OrganizationManagerPermission.new(user)
    elsif user.registered_user?
      RegisteredUserPermission.new(user)
    else
      NullPermission.new
    end
  end
end
