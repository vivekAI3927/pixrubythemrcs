# == Schema Information
#
# Table name: question_categories
#
#  id             :bigint           not null, primary key
#  title          :string
#  no_of_question :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class QuestionCategory < ApplicationRecord
	validates :title, presence: true
  validates_length_of :title, :maximum => 255
  validates :no_of_question, presence: true
end
