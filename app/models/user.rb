class User < ActiveRecord::Base
  include RoleManagement
  include Invitable
  include PasswordResets

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_secure_password validations: false
  mount_uploader :avatar, AvatarUploader, mount_on: :avatar_file_name

  belongs_to :organization
  has_many :documents
  has_many :attempts, class_name: 'Rapidfire::Attempt'

  validates :first_name,            presence: true
  validates :last_name,             presence: true
  validates :email,                 presence: true,
                                    format: { with: VALID_EMAIL_REGEX },
                                    uniqueness: { case_sensitive: false }
  validates :password,              presence: { on: :create },
                                    confirmation: { if: lambda { |m| m.password.present? } },
                                    length: { minimum: 6, if: lambda { |m| m.password.present? } },
                                    if: :password_required?
  validates :password,              presence: { on: :update }, if: :signing_up
  validates :password_confirmation, presence: { if: lambda { |m| m.password.present? } }
  validates :organization_id,       presence: true

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

  def organization_name
    organization.try(:name) || ''
  end

  private

  def check_password
    raise "Password digest missing on new record" if password_required? && password_digest.blank?
  end
end
