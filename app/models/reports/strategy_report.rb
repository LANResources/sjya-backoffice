class Reports::StrategyReport < Reports::Report
  attr_accessor :strategies, :total_activities

  def build
    Rails.cache.fetch self do
      @strategies = Hash[Rapidfire::Question.strategies_question.answer_options.split("\r\n").map{|opt| [opt, 0] }]

      activities = Rapidfire::Attempt.includes(:answers).date_range(@start_date, @end_date)
      @total_activities = activities.count

      strategy_answers = Rapidfire::Answer.where(attempt_id: activities.pluck(:id).uniq, question_id: Rapidfire::Question.strategies_question.id).pluck(:answer_text)
      strategy_answers.each do |strategy_answer|
        strategy_answer.split(',,,').each do |strategy|
          @strategies[strategy] += 1
        end
      end

      self
    end
  end

  def title
    'Strategy Report'
  end
end
