class Reports::ReportBuilder
  include ActiveModel::Model 
  attr_accessor :type, :view_template, :report_class, :report

  validates_presence_of :type, :view_template, :report_class

  def initialize(attributes = {})
    super

    @report_class = case @type
                    when 'coalitions' then Reports::CoalitionReport
                    when 'coalition-meetings' then Reports::CoalitionMeetingReport
                    when 'activity-summary' then Reports::ActivitySummaryReport
                    when 'major-matrix' then Reports::MajorMatrixReport
                    when 'strategy' then Reports::StrategyReport
                    end

    @view_template = @type.try(:underscore)
  end

  def build(attributes = {})
    @report = @report_class.new(attributes).build
  end

end