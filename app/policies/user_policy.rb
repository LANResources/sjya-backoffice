class UserPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def new?
    user >= :organization_manager
  end

  def create?
    (user >= :site_manager && user > resource) || 
      (user.organization_manager? && user.organization == resource.organization) || 
      user.administrator?
  end

  def edit?
    update?
  end

  def update?
    user == resource || (create? && !resource.administrator?)
  end

  def destroy?
    create? && !resource.administrator? && user != resource
  end

  def permitted_attributes
    attributes = [:first_name, :last_name, :email, :password, :password_confirmation,
                          :title, :phone, :address, :city, :state, :zipcode, :avatar]
    attributes += [:role, :organization_id] if user >= :site_manager && user > resource
    attributes
  end
end
