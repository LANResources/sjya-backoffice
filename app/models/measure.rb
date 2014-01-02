class Measure < ActiveRecord::Base
  belongs_to :source
  belongs_to :document
  has_many :measurements, dependent: :destroy

  validates_presence_of :description, :source

  before_save :clean

  private

  def clean
    if link && link.blank?
      self.link = nil
    end
  end
end
