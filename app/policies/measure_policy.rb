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
    user.administrator?
  end

  def edit?
    update?
  end

  def update?
    user.administrator?
  end

  def destroy?
    user.administrator?
  end

  def permitted_attributes
    [:description, :link, :document_id, :source_id]
  end
end
