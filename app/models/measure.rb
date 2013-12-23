class Measure < ActiveRecord::Base
  belongs_to :source
  belongs_to :document
  has_many :measurements
end
