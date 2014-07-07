class ReportPolicy < ApplicationPolicy

  def index?
    user >= :site_manager
  end

  def show?
    user >= :site_manager
  end
end
