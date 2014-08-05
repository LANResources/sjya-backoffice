class Reports::CoalitionReport < Reports::Report
  attr_accessor :sectors, :activity_count

  def initialize(attributes = {})
    super

    @activity_count = 0
    @sectors = {}    
  end

  def build
    Rails.cache.fetch self do 
      Sector.with_user_count.each do |sector| 
        @sectors[sector.id] = { name: sector.name, members: sector.user_count, involvement: 0, average_involvement: 100.0 }
      end

      participant_list_question = Rapidfire::Question.participant_list_question

      Rapidfire::Attempt.date_range(@start_date, @end_date).each do |attempt|
        @activity_count += 1

        attempt.sectors_involved.each do |attempt_sector_id|
          if @sectors[attempt_sector_id]
            @sectors[attempt_sector_id][:involvement] += 1
          end
        end
      end

      @sectors.each do |id,data| 
        @sectors[id][:average_involvement] = (data[:involvement] / @activity_count.to_f) * 100
      end unless @activity_count == 0

      self
    end
  end

  def title
    'User/Coalition Report'
  end
end