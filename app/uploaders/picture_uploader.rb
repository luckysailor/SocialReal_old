# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :file

  def store_dir
    "uploads/#{model.id}/#{model.class.to_s.underscore}/#{mounted_as}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

   version :normal do
     process :resize_to_fit => [150, 150]
   end

   version :thumb do
     process :resize_to_fill => [50, 50]
   end

   def extension_white_list
     %w(jpg jpeg png)
   end

   def filename
     if original_filename
       extension = original_filename.match(/\.(.*)/).captures[0]
       file_name = Digest::MD5.hexdigest(original_filename)
       "#{file_name}.#{extension}"
     end
   end

end
