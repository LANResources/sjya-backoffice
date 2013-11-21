class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit
  include SessionsHelper

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_filter :verify_authenticated

  # delegate :allow?, to: :current_permission
  # helper_method :allow?

  # delegate :allow_param?, to: :current_permission
  # helper_method :allow_param?

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

  # def current_permission
  #   @current_permission ||= Permissions.permission_for(current_user)
  # end

  # def current_resource
  #   nil
  # end

  # def filter_resources
  #   if current_resource.kind_of? ActiveRecord::Relation
  #     filtered_resources = current_permission.filter_resources(params[:controller], params[:action], current_resource)
  #     @current_resource = filtered_resources if filtered_resources.any?
  #   end
  #   filtered_resources.present?
  # end

  # def authorize
  #   if filter_resources || current_permission.allow?(params[:controller], params[:action], current_resource)
  #     current_permission.permit_params! params
  #   else
  #     deny_access
  #   end
  # end
end
