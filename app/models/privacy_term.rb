# == Schema Information
#
# Table name: privacy_terms
#
#  id                 :bigint           not null, primary key
#  title              :string
#  term_and_condition :text
#  note               :text
#  status             :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class PrivacyTerm < ApplicationRecord
	# validates :title, presence: true
  validates_length_of :title, :maximum => 255
  validates :term_and_condition, presence: true
end
