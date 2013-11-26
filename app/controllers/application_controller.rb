class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit
  include SessionsHelper

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_filter :verify_authenticated

  private

  def verify_authenticated
    unless signed_in?
      deny_access
      false
    end
  end

  def user_not_authorized
    flash[:error] = "You are not authorized to perform this action."
    deny_access
  end
end
