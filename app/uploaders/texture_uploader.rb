# encoding: utf-8

class TextureUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:

  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.user.username}/#{model.id}/#{mounted_as}"
  end

  def default_url
    #For Rails 3.1+ asset pipeline compatibility:
    #asset_path("fallback/" + [version_name, "girl_profile.jpg"].compact.join('_'))
  #
    "fallback/" +  "default_texture.png"
   end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  
  version :v512 do
    process :convert => 'jpg'
    process :orientation
      
      #process :resize_to_fit => [512, nil]
  end
  
  version :v1024 do
    process :convert => 'jpg'
    process :resize_to_fill => [1024, 1024]
  end
  
  version :thumb do
    process :convert => 'jpg'
    process :resize_to_fill => [512, 512]
    process :resize_to_fit => [100, 100]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
   def extension_white_list
     %w(jpg jpeg gif png)
   end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
  
  def orientation
      manipulate! do |img|
        pic = MiniMagick::Image.open(img.path)
        if pic[:width] >= pic[:height]
          img.resize "10000x512"
        else
          img.resize "512x10000"
        end
        img = yield(img) if block_given?
        img
      end
    end
    
  


end

