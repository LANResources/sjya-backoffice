class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_filter :authorize

  delegate :allow?, to: :current_permission
  helper_method :allow?

  delegate :allow_param?, to: :current_permission
  helper_method :allow_param?

  def permitted_params
    @permitted_params ||= PermittedParams.new(params, current_user)
  end
  helper_method :permitted_params

  private

  def current_permission
    @current_permission ||= Permissions.permission_for(current_user)
  end

  def current_resource
    nil
  end

  def filter_resources
    if current_resource.kind_of? ActiveRecord::Relation
      filtered_resources = current_permission.filter_resources(params[:controller], params[:action], current_resource)
      @current_resource = filtered_resources if filtered_resources.any?
    end
    filtered_resources.present?
  end

  def authorize
    if filter_resources || current_permission.allow?(params[:controller], params[:action], current_resource)
      current_permission.permit_params! params
    else
      deny_access
    end
  end
end
