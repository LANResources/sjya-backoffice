class Reports::Report
  include ActiveModel::Model

  attr_accessor :start_date, :end_date, :min_date, :max_date

  TITLES_AND_IDS = [
    ['User/Coalition Report', 'coalitions'],
    ['Coalition Meeting Report', 'coalition-meetings'],
    ['Activity Summary', 'activity-summary'],
    ['Major Matrix Report', 'major-matrix'],
    ['Strategy Report', 'strategy']
  ]
  
  def initialize(attributes = {})
    super
    @start_date = (Date.parse(@start_date) rescue nil) if @start_date
    @end_date = (Date.parse(@end_date) rescue nil) if @end_date

    @min_date ||= Rapidfire::Attempt.minimum(:activity_date)
    @max_date ||= Date.today
  end

  def cache_key
    { 
      class: self.class.to_s, 
      start_date: @start_date, 
      end_date: @end_date, 
      updated: Rapidfire::Attempt.last_updated 
    }
  end
end