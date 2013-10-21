class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  STATUSES = %w[registered invited contact_only]
  ROLES = %w[contact invited_user registered_user organization_manager site_manager administrator]

  has_secure_password validations: false
  has_attached_file :avatar,
      storage: :dropbox,
      dropbox_credentials: DropboxConfig.credentials,
      styles: { small: "150x150>", thumb: "100x100#", medium: "200x200>", tiny: "42x42#" },
      path: "SJYABackOffice/#{DropboxConfig::SUBFOLDER}/users/:id/:style/:escaped_filename",
      url: "SJYABackOffice/#{DropboxConfig::SUBFOLDER}/users/:id/:style/:escaped_filename",
      default_url: "https://dl.dropboxusercontent.com/u/#{DropboxConfig::USER_ID}/SJYABackOffice/#{DropboxConfig::SUBFOLDER}/users/default/:style/missing.jpg"

  validates :first_name,            presence: true
  validates :last_name,             presence: true
  validates :email,                 presence: true,
                                    format: { with: VALID_EMAIL_REGEX },
                                    uniqueness: { case_sensitive: false }
  validates :status,                presence: true,
                                    inclusion: { in: STATUSES }
  validates :role,                  presence: true,
                                    inclusion: { in: ROLES }
  validates :password,              presence: { on: :create },
                                    confirmation: { if: lambda { |m| m.password.present? } },
                                    length: { minimum: 6, if: lambda { |m| m.password.present? } },
                                    if: :password_required?
  validates :password_confirmation, presence: { if: lambda { |m| m.password.present? } }

  after_initialize :set_status
  before_validation :set_role, if: :new_record?
  before_create :check_password
  before_save { self.email = email.downcase }

  def authenticate(unencrypted_password)
    if status == 'registered'
      super unencrypted_password
    else
      false
    end
  end

  def password_required?
    status == 'registered'
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def contact?; role.nil? || role == 'contact'; end
  def invited_user?; role == 'invited_user'; end
  def registered_user?; role == 'registered_user'; end
  def organization_manager?; role == 'organization_manager'; end
  def site_manager?; role == 'site_manager'; end
  def administrator?; role == 'administrator'; end

  private

  def set_status
    self.status ||= 'contact_only'
  end

  def set_role
    self.role ||= case self.status
                  when 'registered' then 'registered_user'
                  when 'invited' then 'invited_user'
                  when 'contact_only' then 'contact'
                  else 'contact'
                  end
  end

  def check_password
    raise "Password digest missing on new record" if password_required? && password_digest.blank?
  end
end
