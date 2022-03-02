# == Schema Information
#
# Table name: resources
#
#  id                 :bigint           not null, primary key
#  title              :string
#  description        :text
#  available          :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#
class Resource < ApplicationRecord

	mount_uploader :image_file_name, ResourceImageUploader

	validates :title, presence: true
  validates_length_of :title, :maximum => 255
  validates :description, presence: true
  validates :image_file_name, presence: true

	def image
    image_file_name
  end

  def image?
    image_file_name.present?
  end
  
	# has_attached_file :image,
 #    storage: :s3,
 #    s3_credentials: "#{Rails.root}/config/s3.yml",
 #    s3_permissions: "public-read",
 #    path: "resources/:id/:filename",
 #    bucket: "passmrcs-production"
end
