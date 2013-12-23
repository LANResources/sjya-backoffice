class Measurement < ActiveRecord::Base
  belongs_to :measure
  belongs_to :document
end
