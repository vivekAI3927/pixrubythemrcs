# == Schema Information
#
# Table name: teams
#
#  id         :bigint           not null, primary key
#  name       :string
#  title      :string
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  bio        :text
#  position   :integer
#
class Team < ApplicationRecord
  default_scope { order('position ASC') }

	mount_uploader :image, TeamImageUploader
	validates :name, presence: true
  validates_length_of :name, :maximum => 255
  validates :title, presence: true
  validates_length_of :title, :maximum => 255
  validates :bio, presence: true
  validates :image, presence: true

end
