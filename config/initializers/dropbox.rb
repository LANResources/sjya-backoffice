class DropboxConfig
  ACCESS_TOKEN = ENV["DROPBOX_ACCESS_TOKEN"]
  USER_ID = ENV["DROPBOX_USER_ID"]
  SUBFOLDER = Rails.env == 'staging' ? 'production' : Rails.env

  def self.credentials
    {
      access_token: ACCESS_TOKEN,
      user_id: USER_ID
    }
  end
end

CarrierWave.configure do |config|
  config.dropbox_access_token = DropboxConfig::ACCESS_TOKEN
  config.dropbox_user_id = DropboxConfig::USER_ID
end
