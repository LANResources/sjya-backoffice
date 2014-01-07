class Measurement < ActiveRecord::Base
  belongs_to :measure, touch: true
  belongs_to :document

  validates_presence_of :value, :year
end
