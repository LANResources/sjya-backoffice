module Rapidfire
  class QuestionPolicy < ApplicationPolicy
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
      [:type, :question_text, :position, :answer_options, :validation_rules, :help_text, :allow_custom, :follow_up_for_id, :follow_up_for_condition]
    end
  end
end
