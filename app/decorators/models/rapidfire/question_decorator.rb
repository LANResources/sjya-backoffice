Rapidfire::Question.class_eval do
  after_save :clear_cache

  def self.cached_question(cache_name, type, question_text, follow_up_to_question = nil)
    Rails.cache.fetch "rapidfire/#{cache_name.to_s.dasherize}-question" do
      if follow_up_to_question && respond_to?(follow_up_to_question)
        follow_up_to_question = send(follow_up_to_question)
      end
      (follow_up_to_question.try(:follow_up_questions) || self)
        .where(type: "Rapidfire::Questions::#{type.to_s.camelize}")
        .where('question_text ILIKE ?', "%#{Array(question_text).join('%')}%").first
    end
  end

  def self.attendance_question
    cached_question :attendance, :numeric, %w[how many people involved]
  end

  def self.participant_question
    cached_question :participant, :radio, %w[participants members coalition]
  end

  def self.participant_list_question
    cached_question :participant_list, :user_multi_select, nil, :participant_question
  end

  def self.sectors_served_question
    cached_question :sectors_served, :sector_checkbox, %w[sectors served]
  end

  def self.adult_volunteer_hours_prelim_question
    cached_question :adult_volunteer_hours_prelim, :radio, %w[adult volunteer hours]
  end

  def self.adult_volunteer_hours_question 
    cached_question :adult_volunteer_hours, :numeric, 'hours', :adult_volunteer_hours_prelim_question
  end

  def self.youth_volunteer_hours_prelim_question
    cached_question :youth_volunteer_hours_prelim, :radio, %w[youth volunteer hours]
  end

  def self.youth_volunteer_hours_question 
    cached_question :youth_volunteer_hours, :numeric, 'hours', :youth_volunteer_hours_prelim_question
  end

  def self.success_question
    cached_question :success, :radio, %w[how successful]
  end

  def self.matrix_boxes_question
    cached_question :matrix_boxes, :radio, %w[matrix box]
  end

  def self.strategies_question
    cached_question :strategies, :checkbox, 'strategy'
  end

  private 

  def clear_cache
    Rails.cache.delete 'rapidfire/participant-question'
    Rails.cache.delete 'rapidfire/participant-list-question'
  end
end
