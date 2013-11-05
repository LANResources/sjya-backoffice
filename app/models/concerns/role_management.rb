module RoleManagement
  extend ActiveSupport::Concern

  included do
    STATUSES = %w[registered invited contact_only]
    ROLES = %w[contact registered_user organization_manager site_manager administrator]

    validates :role, presence: true,
                     inclusion: { in: ROLES }

    before_validation :set_role, if: :new_record?
  end

  def status
    if invite_token.nil?
      if role == 'contact' || password_digest.nil?
        'contact_only'
      else
        'registered'
      end
    else
      'invited'
    end
  end

  def invited?
    status == 'invited'
  end

  def registered?
    status == 'registered'
  end

  def contact?
    role.nil? || role == 'contact'
  end

  def registered_user?
    role == 'registered_user'
  end

  def organization_manager?
    role == 'organization_manager'
  end

  def site_manager?
    role == 'site_manager'
  end

  def administrator?
    role == 'administrator'
  end

  def assignable_roles
    case self.role
    when "administrator"
      ROLES
    when "site_manager"
      ROLES[0..3]
    when "organization_manager"
      ROLES[0..1]
    else
      []
    end
  end

  private
    def set_role
      self.role ||= self.status == 'contact_only' ? 'contact' : 'registered_user'
    end
end
