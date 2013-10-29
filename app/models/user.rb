class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  STATUSES = %w[registered invited contact_only]
  ROLES = %w[contact registered_user organization_manager site_manager administrator]

  has_secure_password validations: false
  has_attached_file :avatar,
      storage: :dropbox,
      dropbox_credentials: DropboxConfig.credentials,
      styles: { small: "150x150>", thumb: "100x100#", medium: "200x200>", tiny: "42x42#" },
      path: "SJYABackOffice/#{DropboxConfig::SUBFOLDER}/users/:id/:style/:escaped_filename",
      url: "SJYABackOffice/#{DropboxConfig::SUBFOLDER}/users/:id/:style/:escaped_filename",
      default_url: "https://dl.dropboxusercontent.com/u/#{DropboxConfig::USER_ID}/SJYABackOffice/#{DropboxConfig::SUBFOLDER}/users/default/:style/missing.jpg"

  has_many :invitees, class_name: 'User', foreign_key: 'invited_by', dependent: :nullify
  belongs_to :inviter, class_name: 'User', foreign_key: 'invited_by'

  attr_accessor :signing_up

  validates :first_name,            presence: true
  validates :last_name,             presence: true
  validates :email,                 presence: true,
                                    format: { with: VALID_EMAIL_REGEX },
                                    uniqueness: { case_sensitive: false }
  validates :role,                  presence: true,
                                    inclusion: { in: ROLES }
  validates :password,              presence: { on: :create },
                                    confirmation: { if: lambda { |m| m.password.present? } },
                                    length: { minimum: 6, if: lambda { |m| m.password.present? } },
                                    if: :password_required?
  validates :password,              presence: { on: :update }, if: :signing_up
  validates :password_confirmation, presence: { if: lambda { |m| m.password.present? } }

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

  def invited?; status == 'invited'; end
  def registered?; status == 'registered'; end
  def contact?; role.nil? || role == 'contact'; end
  def registered_user?; role == 'registered_user'; end
  def organization_manager?; role == 'organization_manager'; end
  def site_manager?; role == 'site_manager'; end
  def administrator?; role == 'administrator'; end

  def send_invite(invitee)
    invitee.update_attributes!  role: invitee.contact? ? 'registered_user' : invitee.role,
                                invite_token: User.generate_token(:invite_token),
                                invited_by: self.id,
                                invited_at: Time.zone.now
    UserMailer.invitation(invitee).deliver
  end

  def uninvite(invitee)
    invitee.update_attributes!  role: 'contact',
                                invite_token: nil,
                                invited_by: nil,
                                invited_at: nil
  end

  def register(token, user_params)
    self.signing_up = true

    if invite_token == token && update(user_params)
      self.invite_token = nil
      save!
    else
      false
    end
  end

  private

  def set_role
    self.role ||= self.status == 'contact_only' ? 'contact' : 'registered_user'
  end

  def check_password
    raise "Password digest missing on new record" if password_required? && password_digest.blank?
  end

  def self.generate_token(column)
    begin
      token = SecureRandom.urlsafe_base64
    end while User.exists?(column => token)
    token
  end
end
