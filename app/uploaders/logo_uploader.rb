# encoding: utf-8

class LogoUploader < CarrierWave::Uploader::Base
  include CarrierWave::Compatibility::Paperclip
  include CarrierWave::MiniMagick

  storage :dropbox

  def store_dir
    "SJYABackOffice/#{DropboxConfig::SUBFOLDER}/#{model.class.to_s.underscore}/#{model.id}"
  end

  def default_url
    "https://dl.dropboxusercontent.com/u/#{DropboxConfig::USER_ID}/SJYABackOffice/#{DropboxConfig::SUBFOLDER}/organizations/default/#{version_name}/missing_organization.png"
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  version :small do
    resize_to_limit 150, 150
  end

  version :thumb do
    resize_to_limit 100, 100
  end
  
  version :medium do 
    resize_to_limit 200, 200
  end
  
  version :tiny do
    resize_to_limit 42, 42
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
