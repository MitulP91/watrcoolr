class ImageUploader < CarrierWave::Uploader::Base
	include CarrierWave::RMagick

	include Sprockets::Helpers::RailsHelper
	include Sprockets::Helpers::IsolatedHelper

	storage :file

	def store_dir
		"uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
	end


	def extension_white_list
		%w(jpg jpeg gif png)
	end

	version :thumb do 
		process :resize_to_fit => [50,50]
	end

	version :medium do 
		process :resize_to_fit => [350, 350]
	end


end