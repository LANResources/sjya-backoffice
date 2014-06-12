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

        answer_row = at.answers.find_by(question_id: 6)
        members = answer_row.answer_text.to_i
        @report[sector][:members] += members

        @report[sector][:involvement] += (Rapidfire::Answer.where(answer_text: '2').count * 100) / Rapidfire::Attempt.count
      end
    end
  end

end
