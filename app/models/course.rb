# == Schema Information
#
# Table name: courses
#
#  id                 :integer          not null, primary key
#  title              :string(255)      not null
#  description        :text             not null
#  booking            :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  available          :boolean
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  member_code        :string(255)
#  slug               :string(255)
#

class Course < ApplicationRecord
  extend FriendlyId

  validates :title, presence: true
  validates_length_of :title, :maximum => 255
  validates_length_of :member_code, :maximum => 255
  validates :description, presence: true

  scope :available, -> { where(available: true)}
  mount_uploader :image_file_name, CourseImageUploader

  # has_attached_file :image,
  # storage: :s3,
  # s3_credentials: "#{Rails.root}/config/s3.yml",
  # s3_permissions: "public-read",
  # path: "courses/:id/:style/:filename",
  # bucket: "passmrcs-production"

  friendly_id :title, use: :slugged

  def image
    image_file_name
  end

  def image?
    image_file_name.present?
  end

  def remove_image
    self.image = nil
    self.save
  end

end
