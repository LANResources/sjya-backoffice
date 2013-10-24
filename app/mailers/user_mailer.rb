class UserMailer < ActionMailer::Base
  default from: "no-reply@youth-alliance.backofficeapps.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user.invitation.subject
  #
  def invitation(user)
    @user = user

    mail  to: @user.email,
          from: 'St. Joseph Youth Alliance <invitations@youth-alliance.backofficeapps.com>',
          subject: 'Registration Invitation'
  end
end
