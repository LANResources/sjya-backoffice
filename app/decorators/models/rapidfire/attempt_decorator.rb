Rapidfire::Attempt.class_eval do
  scope :date_range, ->(start_date, end_date) { 
    if start_date && end_date
      where(activity_date: start_date..end_date)
    elsif start_date
      where('activity_date >= ?', start_date)
    elsif end_date
      where('activity_date <= ?', end_date)
    else
      all
    end
  }

  after_save :clear_cache

  def self.last_updated
    Rails.cache.fetch([name, 'last-updated']) do
      maximum(:updated_at).try(:utc)
    end
  end

  def cached_answers
    Rails.cache.fetch([self, 'answers']) do
      answers.to_a
    end
  end

  def coalition_participant_ids
    (cached_answers.select{|a| a.question_id == Rapidfire::Question.participant_list_question.id }.first.try(:answer_text).try(:split, ',,,') || []).map(&:to_i)
  end

  def sectors_involved
    sectors_by_user = Sector.by_user
    coalition_participant_ids.map{|participant| sectors_by_user[participant] }.uniq
  end

  def sectors_served
    question_id = Rapidfire::Question.sectors_served_question.id
    (cached_answers.select{|a| a.question_id == question_id }.first.try(:answer_text).try(:split, ',,,') || []).map(&:to_i)
  end

  def participant_count
    question_id = Rapidfire::Question.attendance_question.id
    cached_answers.select{|a| a.question_id == question_id }.first.try(:answer_text).try(:to_i) || 0
  end

  def adult_volunteer_hours
    question_id = Rapidfire::Question.adult_volunteer_hours_question.id
    cached_answers.select{|a| a.question_id == question_id }.first.try(:answer_text).try(:to_i) || 0
  end

  def youth_volunteer_hours
    question_id = Rapidfire::Question.youth_volunteer_hours_question.id
    cached_answers.select{|a| a.question_id == question_id }.first.try(:answer_text).try(:to_i) || 0
  end

  def how_successful
    question_id = Rapidfire::Question.success_question.id
    case cached_answers.select{|a| a.question_id == question_id }.first.try(:answer_text)
    when /very/i then :very
    when /moderately/i then :moderately
    else :not_at_all
    end
  end

  private

  def clear_cache
    Rails.cache.delete [self, 'answers']
    Rails.cache.delete [self.class.name, 'last-updated']
  end
end
