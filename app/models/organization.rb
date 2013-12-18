class Organization < ActiveRecord::Base
  has_many :users
  belongs_to :sector
  mount_uploader :logo, LogoUploader
  validates_presence_of :name
  validates_presence_of :sector, unless: lambda {|org| org.name == 'LAN Resources' }

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
