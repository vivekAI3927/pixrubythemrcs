# == Schema Information
#
# Table name: questions
#
#  id                        :integer          not null, primary key
#  content                   :text
#  position                  :integer
#  station_id                :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  image_file_name           :string(255)
#  image_content_type        :string(255)
#  image_file_size           :integer
#  image_updated_at          :datetime
#  answer_text               :text
#  answer_image_file_name    :string(255)
#  answer_image_content_type :string(255)
#  answer_image_file_size    :integer
#  answer_image_updated_at   :datetime
#  image_text                :string(255)
#  image_url                 :string(255)
#  answer_image_text         :string(255)
#  answer_image_url          :string(255)
#

class Question < ApplicationRecord

	acts_as_list scope: :station
  attr_accessor :delete_image
  attr_accessor :delete_answer_image


  belongs_to :station
  validates :content, presence: true
  validates_length_of :image_text, :maximum => 255
  validates :position, presence: true
  validates :answer_text, presence: true
  # validates_presence_of :content

  # has_attached_file :image,
  #   storage: :s3,
  #   s3_credentials: "#{Rails.root}/config/s3.yml",
  #   s3_permissions: "public-read",
  #   path: "questions/:id/:style/:filename",
  #   bucket: "passmrcs-production"
  mount_uploader :image_file_name, QuestionImageUploader

  # has_attached_file :answer_image,
  #   storage: :s3,
  #   s3_credentials: "#{Rails.root}/config/s3.yml",
  #   s3_permissions: "public-read",
  #   path: "answers/:id/:style/:filename",
  #   bucket: "passmrcs-production"
  mount_uploader :answer_image_file_name, AnswerImageUploader

  has_many :ratings
  
  def image
    image_file_name
  end

  def image?
    image_file_name.present?
  end
  
  def answer_image
    answer_image_file_name
  end

  def answer_image?
    answer_image_file_name.present?
  end
  def last?(station)
  	# station = Station.find_by_id(station.id)
  	self == station.questions.last ? true : false
  end

  def string_last?(station)
    # station = Station.find(station.id)
    self == station.questions.last ? "last" : "not last"
  end

  def penultimate?(station)
    # station = Station.find_by_id(station.id)
    # self == station.questions[-1] ? true : false
    self == station.questions.last ? true : false
  end

  def string_penultimate?(station)
    # station = Station.find_by_id(station.id)
    self == station.questions[-2] ? "penultimate" : "not penultimate"
  end

  def next
    Question.where("station_id = ? AND position = ?", self.station_id, (self.position + 1)).first
  end

  def to_s
    self.content
  end

  def remove_image
    self.image = nil
    self.save
  end

  def remove_answer_image
    self.answer_image = nil
    self.save
  end

  def move_up
    self.move_higher
  end

  def move_down
    self.move_lower
  end

end
