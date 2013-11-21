class OrganizationPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    user >= :site_manager
  end

  def edit?
    update?
  end

  def update?
    user >= :site_manager || (user.organization_manager? && user.organization == resource)
  end

  def destroy?
    user.administrator?
  end

  def permitted_attributes
    [:name, :logo]
  end
end
