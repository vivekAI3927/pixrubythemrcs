# == Schema Information
#
# Table name: exams
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  current_station :integer
#  stations        :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Exam < ApplicationRecord

  serialize :stations

  belongs_to :user

  validates :user_id, :stations, :current_station, presence: true
end
