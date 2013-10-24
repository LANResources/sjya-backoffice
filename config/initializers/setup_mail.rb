ActionMailer::Base.smtp_settings = {
  address:              ENV['MAIL_ADDRESS'],
  port:                 ENV['MAIL_PORT'],
  domain:               ENV['MAIL_DOMAIN'],
  user_name:            ENV['MAIL_USER_NAME'],
  password:             ENV['MAIL_PASSWORD'],
  authentication:       :login,
  enable_starttls_auto: true,
  openssl_verify_mode:  'none'
}
