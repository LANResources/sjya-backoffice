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
      true
    end

    def update?
      true
    end

    def destroy?
      true
    end

    def permitted_attributes
      []
    end
  end
end
