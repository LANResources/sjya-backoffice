class UserMailer < ActionMailer::Base
  default from: "no-reply@youth-alliance.backofficeapps.com"

  def invitation(user)
    @user = user

    mail  to: @user.email,
          from: 'St. Joseph Youth Alliance <invitations@youth-alliance.backofficeapps.com>',
          subject: 'Registration Invitation'
  end

  def password_reset(user)
    @user = user
    mail  to: @user.email,
          from: 'St. Joseph Youth Alliance <password-resets@youth-alliance.backofficeapps.com>',
          subject: "Password Reset"
  end
end
