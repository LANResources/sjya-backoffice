module Rapidfire
  class AttemptPolicy < ApplicationPolicy
    def index?
      true
    end

    def show?
      true
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
      [:description, :completed_for, :activity_date]
    end
  end
end
