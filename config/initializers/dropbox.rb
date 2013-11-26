class DropboxConfig
  APP_KEY = ENV["DROPBOX_APP_KEY"]
  APP_SECRET = ENV["DROPBOX_APP_SECRET"]
  ACCESS_TOKEN = ENV["DROPBOX_ACCESS_TOKEN"]
  ACCESS_TOKEN_SECRET = ENV["DROPBOX_ACCESS_TOKEN_SECRET"]
  USER_ID = ENV["DROPBOX_USER_ID"]
  ACCESS_TYPE = ENV["DROPBOX_ACCESS_TYPE"]
  SUBFOLDER = Rails.env == 'staging' ? 'production' : Rails.env

  def self.credentials
    {
      app_key: APP_KEY,
      app_secret: APP_SECRET,
      access_token: ACCESS_TOKEN,
      access_token_secret: ACCESS_TOKEN_SECRET,
      user_id: USER_ID,
      access_type: ACCESS_TYPE
    }
  end
end

CarrierWave.configure do |config|
  config.dropbox_app_key = DropboxConfig::APP_KEY
  config.dropbox_app_secret = DropboxConfig::APP_SECRET
  config.dropbox_access_token = DropboxConfig::ACCESS_TOKEN
  config.dropbox_access_token_secret = DropboxConfig::ACCESS_TOKEN_SECRET
  config.dropbox_user_id = DropboxConfig::USER_ID
  config.dropbox_access_type = "dropbox"
end
