class Document < ActiveRecord::Base
  belongs_to :user
  mount_uploader :item, DocumentUploader
  acts_as_taggable

  validates_presence_of :item

  before_save :set_default_title, :set_item_metadata

  def filename
    item.path.split('/').last
  end

  def name
    title || filename
  end

  def owner_name
    user.full_name
  end

  private

  def set_default_title
    self.title = self.filename if title.blank?
  end

  def set_item_metadata
    if item.present? && item_changed?
      self.item_size = item.file.size
      self.content_type = item.file.content_type
    end
  end
end
