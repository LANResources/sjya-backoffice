class Reports::CoalitionMeetingReport < Reports::Report

  attr_reader :meeting_count, :average_attendance, :average_coalition_member_attendance, :sectors, :involvement_score

  def initialize(attributes = {})
    super

    @sectors = {}
    @average_attendance = 0
    @average_coalition_member_attendance = 0
    @involvement_score = 0
  end

  def build
    Rails.cache.fetch self do
      meetings = Rapidfire::Attempt.where(activity_type: 'Coalition Meeting').date_range(@start_date, @end_date)

      meeting_ids = meetings.pluck(:id)

      # Meeting Count
      @meeting_count = meetings.count

      # Average Attendance
      attendance = Rapidfire::Question.attendance_question.answers.where(attempt_id: meeting_ids).pluck(:answer_text).map(&:to_i)
      @average_attendance = attendance.inject(:+) / attendance.size.to_f

      # Sector Involvment
      Sector.all.each{|sector| @sectors[sector.id] = {name: sector.name, meetings_attended: 0, average_involvement: 0.0}}

      meetings.each do |meeting|
        meeting.sectors_involved.each do |meeting_sector_id|
          if @sectors[meeting_sector_id]
            @sectors[meeting_sector_id][:meetings_attended] += 1
          end
        end
      end

      @sectors.each do |id,data| 
        @sectors[id][:average_involvement] = (data[:meetings_attended] / @meeting_count.to_f) * 100
      end unless @meeting_count == 0

      # Coalition Member Attendance
      total_coalition_member_attendance = Rapidfire::Question.participant_list_question.answers
                                            .where(attempt_id: meeting_ids).pluck(:answer_text)
                                            .map{|a| a.split(',,,') }.flatten.size
      @average_coalition_member_attendance = total_coalition_member_attendance / @meeting_count.to_f

      # Coalition Member Involvement
      @involvement_score = (@average_coalition_member_attendance / @average_attendance) * 100

      self
    end
  end

  def title
    'Coalition Meeting Report'
  end

  def involvement
    case @involvement_score
    when 0...40 then 'Low'
    when 40...60 then 'Medium'
    when 60...70 then 'High'
    else 'High'
    end
  end
end