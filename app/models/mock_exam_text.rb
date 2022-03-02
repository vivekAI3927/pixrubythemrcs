# == Schema Information
#
# Table name: mock_exam_texts
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class MockExamText < ApplicationRecord
	validates :title, presence: true
  validates_length_of :title, :maximum => 255
  validates :description, presence: true
end
