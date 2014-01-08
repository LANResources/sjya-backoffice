# encoding: utf-8

class DocumentUploader < CarrierWave::Uploader::Base
  storage :dropbox

  def store_dir
    ['SJYABackOffice', DropboxConfig::SUBFOLDER, model.class.to_s.pluralize.underscore, model.user_id, model.id].join '/'
  end

  def extension_white_list
    %w(jpg jpeg gif png pdf doc docx xls slsx ppt pptx)
  end
end
