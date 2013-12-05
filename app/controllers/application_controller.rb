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

  def sort_column(columns, default)
    columns.include?(params[:sort]) ? params[:sort] : default
  end
  helper_method :sort_column

  def sort_direction(default = 'asc')
    %w[asc desc].include?(params[:direction]) ? params[:direction] : default
  end
  helper_method :sort_direction
end
