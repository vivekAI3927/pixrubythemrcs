# == Schema Information
#
# Table name: answers
#
#  id                 :integer          not null, primary key
#  question_id        :integer
#  content            :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Answer < ApplicationRecord
	mount_uploader :image_file_name, AnswerImageUploader

  # has_attached_file :image,
  #   storage: :s3,
  #   s3_credentials: "#{Rails.root}/config/s3.yml",
  #   s3_permissions: "public-read",
  #   path: ":filename",
  #   bucket: "passmrcs-dev"
  
  def image
    image_file_name
  end

  def image?
    image_file_name.present?
  end

end
