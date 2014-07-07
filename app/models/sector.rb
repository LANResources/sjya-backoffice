class Sector < ActiveRecord::Base
  has_many :organizations
  has_many :users, through: :organizations
  validates_presence_of :name

  def self.with_user_count
    joins(:users).select('sectors.id, sectors.name, count(users.*) as user_count').group('sectors.id')
  end
  
  def self.by_user
    Rails.cache.fetch('sectors-by-user') do
      user_sectors = {}
      Organization.all.map do |org|
        org.user_ids.each do |user_id|
          user_sectors[user_id] = org.sector_id 
        end
      end
      user_sectors
    end
  end
end
