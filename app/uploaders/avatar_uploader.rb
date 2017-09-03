# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    [S3Config::SUBFOLDER, model.class.to_s.pluralize.underscore, model.id].join '/'
  end

  def default_url
    "https://#{S3Config::BUCKET}.s3.us-east-3.amazonaws.com/#{S3Config::SUBFOLDER}/users/default/#{version_name}/missing.png"
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
