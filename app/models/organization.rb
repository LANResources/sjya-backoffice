class Organization < ActiveRecord::Base

  has_many :users
  has_attached_file :logo,
    storage: :dropbox,
    dropbox_credentials: DropboxConfig.credentials,
    styles: { small: "150x150>", thumb: "100x100#", medium: "200x200>", tiny: "42x42#" },
    path: "SJYABackOffice/#{DropboxConfig::SUBFOLDER}/organizations/:id/:style/:escaped_filename",
    url: "SJYABackOffice/#{DropboxConfig::SUBFOLDER}/organizations/:id/:style/:escaped_filename",
    default_url: "https://dl.dropboxusercontent.com/u/#{DropboxConfig::USER_ID}/SJYABackOffice/#{DropboxConfig::SUBFOLDER}/organizations/default/:style/missing_organization.png"

  validates_presence_of :name
end
