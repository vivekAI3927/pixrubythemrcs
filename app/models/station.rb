# == Schema Information
#
# Table name: stations
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  scenario_text      :text
#  trial              :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  category_id        :integer
#  markscheme         :text
#  actor_brief        :text
#  exam_brief         :text
#  cheatsheet         :text
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  videoId            :string(255)
#  available          :boolean          default(TRUE)
#  slug               :string(255)
#  flag               :string           default("TO-DO")
#

class Station < ApplicationRecord
  extend FriendlyId
  attr_accessor :remove_image
  scope :trials, -> {where(trial: true)}
  scope :available, -> { where(available: true)}

  # has_many :questions, order: "position", :dependent => :destroy

  has_many :questions, -> { order(position: :asc) }, :dependent => :destroy
  has_many :attempts, :dependent => :delete_all
  has_many :users, through: :attempts
  # has_one :station_status
  belongs_to :category
  has_many :station_statuses, :dependent => :delete_all

  validates :title, presence: true
  validates_length_of :title, :maximum => 255

  validates :scenario_text, presence: true

  after_create :add_attempts_for_users

  friendly_id :title, use: :slugged

  mount_uploader :image_file_name, StationImageUploader

  # has_attached_file :image,
  #   storage: :s3,
  #   s3_credentials: "#{Rails.root}/config/s3.yml",
  #   s3_permissions: "public-read",
  #   path: "stations/:id/:style/:filename",
  #   bucket: "passmrcs-production"

  def image
    image_file_name
  end

  def image?
    image_file_name.present?
  end

  def add_attempts_for_users
    Station.delay_add_attamps(self.id)
  end 


  def self.delay_add_attamps(station_id)
    users_hash = []
    User.all.each do |user|
      # Attempt.create(station_id: station.id, user_id: user_id)
      users_hash << {station_id: station_id, user_id: user.id, created_at: Time.now, updated_at: Time.now}
    end
    Attempt.insert_all(users_hash) if users_hash.present?
  end



  # def add_attempts_for_users
  #   User.all.each { |user| Attempt.create(station_id: self.id, user_id: user.id) }
  # end

  def first_question
  	self.questions.first
  end
  def update_status(current_user, flag=STATION_TODO)
    station_status ||= StationStatus.find_or_initialize_by(user_id: current_user.id, station_id: self.id)
    station_status.status = flag
    station_status.save
    station_status
  end

  def station_status(current_user)
    station_status ||= StationStatus.where(user_id: current_user.id, station_id: self.id).first
    if station_status.blank?
      station_status = self.update_status(current_user, STATION_TODO)
    end
      station_status  
  end
end
