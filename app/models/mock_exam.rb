# == Schema Information
#
# Table name: mock_exams
#
#  id          :bigint           not null, primary key
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  title       :string
#
class MockExam < ApplicationRecord

	validates :title, presence: true
  validates_length_of :title, :maximum => 255
  validates :description, presence: true
end
