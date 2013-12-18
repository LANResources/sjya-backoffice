class Sector < ActiveRecord::Base
  has_many :organizations
  validates_presence_of :name
end
