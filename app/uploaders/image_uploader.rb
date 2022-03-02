class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # storage :fog
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :icon do
    process :resize_to_fit => [100, 100]
  end

  version :thumb do
    process :resize_to_fit => [260, 260]
  end

  version :large do
    process :resize_to_fit => [450, 450]
  end
end
