# == Schema Information
#
# Table name: footer_records
#
#  id                 :bigint           not null, primary key
#  copyright          :string
#  all_right_reserved :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class FooterRecord < ApplicationRecord
	validates :copyright, presence: true
  validates_length_of :copyright, :maximum => 255
  validates :all_right_reserved, presence: true
  validates_length_of :all_right_reserved, :maximum => 255
end
