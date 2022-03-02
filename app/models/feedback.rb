# == Schema Information
#
# Table name: feedbacks
#
#  id          :bigint           not null, primary key
#  status      :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string
#  description :text
#  star_rating :string
#
class Feedback < ApplicationRecord

	validates :name, presence: true
  validates_length_of :name, :maximum => 255
  validates :description, presence: true
end
