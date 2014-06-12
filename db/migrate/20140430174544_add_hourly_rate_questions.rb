class AddHourlyRateQuestions < ActiveRecord::Migration
  def up
    adult_yes_no_question = create_boolean_question question_text: 'Were there any adult volunteer hours generated by this activity?'
    youth_yes_no_question = create_boolean_question question_text: 'Were there any youth volunteer hours generated by this activity?'

    adult_hours_question = Rapidfire::Question.where(question_text: "Adult volunteer hours generated from activity?").first
    youth_hours_question = Rapidfire::Question.where(question_text: "Youth volunteer hours generated from activity?").first

    Rapidfire::Attempt.all.each do |attempt|
      create_boolean_answer attempt: attempt, hours_question_id: adult_hours_question.id, boolean_question_id: adult_yes_no_question.id
      create_boolean_answer attempt: attempt, hours_question_id: youth_hours_question.id, boolean_question_id: youth_yes_no_question.id
    end

    set_as_follow_up adult_hours_question, to: adult_yes_no_question, condition: 'Yes'
    set_as_follow_up youth_hours_question, to: youth_yes_no_question, condition: 'Yes'

    create_rate_question follow_up_for: adult_yes_no_question
    create_rate_question follow_up_for: youth_yes_no_question
  end

  def down
  end

  private

  def create_boolean_question(question_text: nil)
    Rapidfire::Survey.first.questions.create  section: 'Participants/Items',
                                              type: 'Rapidfire::Questions::Radio',
                                              question_text: question_text,
                                              answer_options: "Yes\r\nNo",
                                              validation_rules: {
                                                presence: '1',
                                                minimum: '',
                                                maximum: '',
                                                greater_than_or_equal_to: '',
                                                less_than_or_equal_to: ''
                                              }
  end

  def create_boolean_answer(attempt: nil, hours_question_id: nil, boolean_question_id: nil)
    question_answered = attempt.answers.where(question_id: hours_question_id).any? ? 'Yes' : 'No'
    attempt.answers.create question_id: boolean_question_id, answer_text: question_answered
  end

  def set_as_follow_up(question, to: nil, condition: nil)
    question.question_text = 'Number of hours:'
    question.follow_up_for_id = to.id
    question.follow_up_for_condition = condition
    question.save
  end

  def create_rate_question(follow_up_for: nil)
    Rapidfire::Survey.first.questions.create  section: 'Participants/Items',
                                              type: 'Rapidfire::Questions::Short',
                                              question_text: 'Hourly Rate:',
                                              answer_options: '',
                                              validation_rules: {
                                                presence: nil,
                                                minimum: nil,
                                                maximum: nil,
                                                greater_than_or_equal_to: nil,
                                                less_than_or_equal_to: nil
                                              },
                                              follow_up_for_id: follow_up_for.id,
                                              follow_up_for_condition: 'Yes'
  end
end