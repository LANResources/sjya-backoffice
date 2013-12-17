module Rapidfire
  class QuestionPolicy < ApplicationPolicy
    def index?
      user.administrator?
    end

    def show?
      user.administrator?
    end

    def new?
      user.administrator?
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
      [:type, :question_text, :position, :answer_options, :validation_rules, :help_text, :allow_custom, :follow_up_for_id, :follow_up_for_condition, :section,
        :answer_presence, :answer_minimum_length, :answer_maximum_length, :answer_greater_than_or_equal_to, :answer_less_than_or_equal_to]
    end
  end
end
