module Invitable
  extend ActiveSupport::Concern

  included do
    has_many :invitees, class_name: 'User', foreign_key: 'invited_by', dependent: :nullify
    belongs_to :inviter, class_name: 'User', foreign_key: 'invited_by'

    attr_accessor :signing_up
  end

  module ClassMethods
    def generate_token(column)
      begin
        token = SecureRandom.urlsafe_base64
      end while User.exists?(column => token)
      token
    end
  end

  def send_invite(invitee)
    invitee.update_attributes!  role: invitee.contact? ? 'registered_user' : invitee.role,
                                invite_token: User.generate_token(:invite_token),
                                invited_by: self.id,
                                invited_at: Time.zone.now
    UserMailer.invitation(invitee).deliver
  end

  def uninvite(invitee)
    invitee.update_attributes!  role: 'contact',
                                invite_token: nil,
                                invited_by: nil,
                                invited_at: nil
  end

  def register(token, user_params)
    self.signing_up = true

    if invite_token == token && update(user_params)
      self.invite_token = nil
      save!
    else
      false
    end
  end
end