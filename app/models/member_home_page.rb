# == Schema Information
#
# Table name: member_home_pages
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class MemberHomePage < ApplicationRecord

	validates :title, presence: true
  validates_length_of :title, :maximum => 255
  validates :description, presence: true
end
