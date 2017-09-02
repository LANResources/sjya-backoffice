# encoding: utf-8

class LogoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :dropbox

  def store_dir
    ['SJYABackOffice', DropboxConfig::SUBFOLDER, model.class.to_s.pluralize.underscore, model.id].join '/'
  end

  def default_url
    url_string = case version_name.try(:to_sym)
    when :small
      "zhxsrm4b2kmjnmv"
    when :thumb
      "m3cwlnhps80uk9v"
    when :medium
      "2klo0tsnwhbqg2n"
    when :tiny
      "ipvdugpsar4owza"
    else
      "9b982ctad6dbfi7"
    end
    "https://www.dropbox.com/s/#{url_string}/missing_organization.png?dl=1"
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
