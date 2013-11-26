class Organization < ActiveRecord::Base
  has_many :users
  mount_uploader :logo, LogoUploader, mount_on: :logo_file_name
  validates_presence_of :name

  scope :assignable_for, ->(user) {
    case user.role
    when 'administrator'
      all
    when 'site_manager'
      where.not name: 'LAN Resources'
    when 'organization_manager'
      where id: user.organization_id
    else
      none
    end
  }
end
