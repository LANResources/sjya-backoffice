module Rapidfire
  class SurveyPolicy < ApplicationPolicy
    def index?
      user.administrator?
    end

    def show?
      true
    end

    def new?
      true
    end

    def create?
      user.administrator?
    end

    def edit?
      user.administrator?
    end

    def update?
      user.administrator?
    end

    def destroy?
      user.administrator?
    end

    def permitted_attributes
      [:name, :active]
    end
  end
end
