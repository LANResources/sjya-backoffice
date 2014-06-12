class Sector < ActiveRecord::Base
  has_many :organizations
  has_many :users, through: :organizations
  validates_presence_of :name
end
