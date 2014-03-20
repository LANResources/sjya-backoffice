class MeasurementPolicy < ApplicationPolicy

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
    [:measure_id, :link, :document_id, :year, :value]
  end
end
