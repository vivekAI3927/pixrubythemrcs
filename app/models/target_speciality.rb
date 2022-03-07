# == Schema Information
#
# Table name: target_specialities
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TargetSpeciality < ApplicationRecord
	# validates :name, presence: true
  # validates_length_of :name, :maximum => 255
end
