# == Schema Information
#
# Table name: categories
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  advice             :text
#  image_url          :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  position           :integer
#  slug               :string(255)
#

class Category < ApplicationRecord
  extend FriendlyId
  attr_accessor :available

  validates :name, presence: true
  validates_length_of :name, :maximum => 255
  validates :advice, presence: true
  validates :position, presence: true

  # acts_as_list

  has_many :stations


  default_scope { order(:position) }

  friendly_id :name, use: :slugged

  mount_uploader :image_file_name, CategoryImageUploader

  # has_attached_file :image,
	 #  storage: :s3,
	 #  s3_credentials: "#{Rails.root}/config/s3.yml",
	 #  s3_permissions: "public-read",
	 #  path: "categories/:id/:style/:filename",
	 #  bucket: "passmrcs-production"

  def image
    image_file_name
  end

  def image?
    image_file_name.present?
  end
  def to_s
  	self.name
  end

  def self.generate_random_stations(name, number)
    stations = self.where("name = ?", name.to_s).first.stations.sample(number).map { |station| station.id}
  end

  def percentage(category_id, user_id)
    # calculate user station percentage
    stations = self.stations
    station_ids = stations.map(&:id)
    @all_attempt = Attempt.where(station_id: station_ids, user_id: user_id)
    return 0 if @all_attempt.count == 0
    @attempts = Attempt.where(station_id: station_ids, started: true, completed: true, user_id: user_id)
    @percentage = ((@attempts.count.to_f / @all_attempt.count.to_f)*100).to_i
  end
end
