# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  storage :fog

  include CarrierWave::MimeTypes
  process :set_content_type

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # for heroku
  # https://github.com/carrierwaveuploader/carrierwave/wiki/How-to%3A-Make-Carrierwave-work-on-Heroku
  if Rails.env == "production"
    def cache_dir
      "#{Rails.root}/tmp/uploads"
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
     %w(jpg jpeg gif png)
  end


  # Create different versions
  version :thumb do
    process :convert => 'jpg'
    process :resize_to_fit => [500, 500]
  end


  # full size
  process :get_meta_info
  # process :convert => 'jpg'

  def meta_info
    @meta_info
  end



  def get_meta_info
    if (@file)

      # chop off all chars off the path
      file_path = @file.file.partition(Rails.root.to_s)[2]

      # remove leading slash
      img = Magick::Image::read(file_path.slice(1..file_path.size)).first
      @meta_info = Hash.new

      # TODO: properties instead of array
      @meta_info = { :height => img.rows, :width => img.columns, :format => img.format }
    end
  end


end
