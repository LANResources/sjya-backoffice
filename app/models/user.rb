class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  STATUSES = %w[registered invited contact_only]

  has_secure_password validations: false
  has_attached_file :avatar,
      storage: :dropbox,
      dropbox_credentials: DROPBOX_CONFIG,
      styles: { small: "150x150>", thumb: "100x100#", medium: "200x200>", tiny: "42x42#" },
      path: "SJYABackOffice/#{DROPBOX_CONFIG[:subfolder]}/users/:id/:style/:escaped_filename",
      url: "SJYABackOffice/#{DROPBOX_CONFIG[:subfolder]}/users/:id/:style/:escaped_filename",
      default_url: "https://dl.dropboxusercontent.com/u/#{DROPBOX_CONFIG[:user_id]}/SJYABackOffice/#{DROPBOX_CONFIG[:subfolder]}/users/default/:style/missing.jpg"

  validates :first_name,            presence: true
  validates :last_name,             presence: true
  validates :email,                 presence: true,
                                    format: { with: VALID_EMAIL_REGEX },
                                    uniqueness: { case_sensitive: false }
  validates :status,                presence: true,
                                    inclusion: { in: STATUSES }
  validates :password,              presence: { on: :create },
                                    confirmation: { if: lambda { |m| m.password.present? } },
                                    length: { minimum: 6 },
                                    if: :password_required?
  validates :password_confirmation, presence: { if: lambda { |m| m.password.present? } }

  after_initialize { self.status ||= 'contact_only' }
  before_create { raise "Password digest missing on new record" if password_required? && password_digest.blank? }
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
end
