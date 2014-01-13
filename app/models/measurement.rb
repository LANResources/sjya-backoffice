class Measurement < ActiveRecord::Base
  belongs_to :measure, touch: true
  belongs_to :document

  validates_presence_of :value, :year

  before_save :clean

  private

  def clean
    if link && link.blank?
      self.link = nil
    end
  end
end
