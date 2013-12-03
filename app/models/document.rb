class Document < ActiveRecord::Base
  belongs_to :user
  mount_uploader :item, DocumentUploader

  validates_presence_of :item

  def filename
    item.path.split('/').last
  end

  def content_type
    item.file.content_type
  end

  def name
    title || filename
  end

  def owner_name
    user.full_name
  end
end
