class Reports::MajorMatrixReport < Reports::Report
  attr_accessor :matrix_boxes, :total_activities

  def build
    Rails.cache.fetch self do
      @matrix_boxes = Hash[Rapidfire::Question.matrix_boxes_question.answer_options.split("\r\n").map{|opt| [opt, 0] }]

      activities = Rapidfire::Attempt.includes(:answers).date_range(@start_date, @end_date)
      @total_activities = activities.count

      matrix_box_answers = Rapidfire::Answer.where(attempt_id: activities.pluck(:id).uniq, question_id: Rapidfire::Question.matrix_boxes_question.id).pluck(:answer_text)
      matrix_box_answers.each do |matrix_box_answer|
        @matrix_boxes[matrix_box_answer] += 1
      end

      self
    end
  end

  def title
    'Major Matrix Report'
  end
end