module PasswordResets
  extend ActiveSupport::Concern

  included do
    attr_accessor :resetting_password

    validates :password, presence: { on: :update }, if: :resetting_password
  end

  def send_password_reset
    generate_token :password_reset_token
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def reset_password(user_params)
    self.resetting_password = true

    if password_reset_sent_at < 2.hours.ago
      :expired
    else 
      update_attributes user_params
    end
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end