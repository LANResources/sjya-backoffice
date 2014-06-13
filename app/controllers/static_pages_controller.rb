class StaticPagesController < ApplicationController
  def about
  end

  def reports
  end

  def coalition_report

    @report = {}

    # {"IT" => {members: 30, involvement: 30}}

    if Rapidfire::Attempt.present?
      Rapidfire::Attempt.all.each do |at|
        answer_row = at.answers.find_by(question_id: 5)
        sector = Sector.find(answer_row.answer_text.to_i).name
        @report[sector] ||= Hash.new(0)
        @report[sector][:involvement] = (Rapidfire::Answer.where(answer_text: answer_row.answer_text).count * 100) / Rapidfire::Attempt.count
        answer_row = at.answers.find_by(question_id: 6)
        members = answer_row.answer_text.to_i
        @report[sector][:members] += members


      end
    end
  end

  def activity_summary
    @summary = {}

    if params[:start_date] and params[:end_date].present?
      activities = Rapidfire::Attempt.where("activity_date >= ? AND activity_date <= ?", params[:start_date], params[:end_date])
      activities.each do |at|
        activity = at.activity_type
        @summary[activity] ||= Hash.new(0)
        @summary[activity][:period] += 1
        @summary[activity][:stop_act] += at.completed_for.include?('Stop ACT') ? 1 : 0
        @summary[activity][:drug_free] += at.completed_for.include?('Drug Free Communities') ? 1 : 0
        @summary[activity][:participants] += at.answers.find_by(question_id: 6).answer_text.to_i
        @summary[activity][:adult] += at.answers.find_by(question_id: 12).answer_text.to_i
        @summary[activity][:youth] += at.answers.find_by(question_id: 13).answer_text.to_i
        @summary[activity][:very] += at.answers.find_by(question_id: 1).answer_text == 'Very Successful' ? 1 : 0
        @summary[activity][:moderate] += at.answers.find_by(question_id: 1).answer_text == 'Moderately Successful' ? 1 : 0
        @summary[activity][:not_successful] += at.answers.find_by(question_id: 1).answer_text == 'Not at All Successful' ? 1 : 0
      end
    else
      if Rapidfire::Attempt.present?
        Rapidfire::Attempt.all.each do |at|
          activity = at.activity_type
          @summary[activity] ||= Hash.new(0)
          @summary[activity][:period] += 1
          @summary[activity][:stop_act] += at.completed_for.include?('Stop ACT') ? 1 : 0
          @summary[activity][:drug_free] += at.completed_for.include?('Drug Free Communities') ? 1 : 0
          @summary[activity][:participants] += at.answers.find_by(question_id: 6).answer_text.to_i
          @summary[activity][:adult] += at.answers.find_by(question_id: 12).answer_text.to_i
          @summary[activity][:youth] += at.answers.find_by(question_id: 13).answer_text.to_i
          @summary[activity][:very] += at.answers.find_by(question_id: 1).answer_text == 'Very Successful' ? 1 : 0
          @summary[activity][:moderate] += at.answers.find_by(question_id: 1).answer_text == 'Moderately Successful' ? 1 : 0
          @summary[activity][:not_successful] += at.answers.find_by(question_id: 1).answer_text == 'Not at All Successful' ? 1 : 0
        end
      end
    end
  end

end
