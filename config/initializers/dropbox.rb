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
