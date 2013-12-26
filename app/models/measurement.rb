class Measurement < ActiveRecord::Base
  belongs_to :measure
  belongs_to :document

  validates_presence_of :value, :year
end
