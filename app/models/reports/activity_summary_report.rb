class Reports::ActivitySummaryReport < Reports::Report
  attr_accessor :activity_types, :sector_count, :success_rate_categories

  def initialize(attributes = {})
    super

    @activity_types = {}
  end

  def build
    Rails.cache.fetch self do
      @sector_count = Sector.count.to_f
      @success_rate_categories = [:very, :moderately, :not_at_all]

      activities_by_type = Rapidfire::Attempt.includes(:answers).date_range(@start_date, @end_date).to_a.group_by(&:activity_type)

      activities_by_type.each do |type, activities|
        @activity_types[type] = {
          activities: activities,
          count: activities.count,
          completed_for_count: Hash[Rapidfire::Attempt::COMPLETED_FOR_OPTIONS.map{|opt| [opt, 0] }],
          total_participants: 0,
          total_impressions: 0,
          total_volunteer_hours: {
            adult: 0,
            youth: 0
          },
          sectors_served: 0,
          success_rate: Hash[@success_rate_categories.map{|category| [category, 0] }]
        }

        activities.each do |activity|
          Rapidfire::Attempt::COMPLETED_FOR_OPTIONS.each do |option|
            @activity_types[type][:completed_for_count][option] += 1 if activity.completed_for.include?(option)
          end

          @activity_types[type][:total_participants] += activity.participant_count
          @activity_types[type][:total_impressions] += activity.impressions_count
          @activity_types[type][:total_volunteer_hours][:adult] += activity.adult_volunteer_hours
          @activity_types[type][:total_volunteer_hours][:youth] += activity.youth_volunteer_hours
          @activity_types[type][:sectors_served] += activity.sectors_served.count
          @activity_types[type][:success_rate][activity.how_successful] += 1
        end
      end

      self
    end
  end

  def title
    'Activity Summary'
  end
end
