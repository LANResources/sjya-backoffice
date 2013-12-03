class DocumentPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def download?
    show?
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    update?
  end

  def update?
    user == resource.user || user >= :site_manager
  end

  def destroy?
    update?
  end

  def permitted_attributes
    [:title, :item]
  end
end
