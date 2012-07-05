# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
   def default_url
    #For Rails 3.1+ asset pipeline compatibility:
    #asset_path("fallback/" + [version_name, "girl_profile.jpg"].compact.join('_'))
  #
    "fallback/" + [version_name, "girl_profile.jpg"].compact.join('_')
   end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  version :medium do
    process :resize_to_fill => [300, 300]
  end
  
  version :thumb200 do
    process :resize_to_fill => [200, 200]
  end
  
  version :thumb do
    process :resize_to_fill => [100, 100]
  end
  
  version :mini do
    process :resize_to_fill => [50, 50]
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
