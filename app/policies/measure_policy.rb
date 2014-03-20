class MeasurePolicy < ApplicationPolicy

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
    user >= :site_manager
  end

  def destroy?
    user >= :site_manager
  end

  def permitted_attributes
    [:description, :link, :document_id, :source_id]
  end
end
