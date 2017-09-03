class S3Config
  KEY = ENV['S3_KEY']
  SECRET = ENV['S3_SECRET']
  REGION = ENV['S3_REGION']
  BUCKET = ENV['S3_BUCKET']
  SUBFOLDER = Rails.env == 'staging' ? 'p' : Rails.env[0]
end

CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:               'AWS',
    aws_access_key_id:      S3Config::KEY,
    aws_secret_access_key:  S3Config::SECRET,
    region:                 S3Config::REGION
  }

  config.storage = :fog
  config.cache_dir = "#{Rails.root}/tmp/uploads" # To let CarrierWave work on heroku

  config.fog_directory = S3Config::BUCKET
end