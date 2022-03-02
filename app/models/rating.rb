# == Schema Information
#
# Table name: ratings
#
#  id          :integer          not null, primary key
#  question_id :integer
#  station_id  :integer
#  review      :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Rating < ApplicationRecord
  belongs_to :user
	belongs_to :question
	belongs_to :station
  validates :review, presence: true
  default_scope { order('created_at DESC') }

  def rating
  	review
  end

end
