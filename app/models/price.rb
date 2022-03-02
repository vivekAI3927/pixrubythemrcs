# == Schema Information
#
# Table name: prices
#
#  id         :bigint           not null, primary key
#  title      :string
#  price      :string
#  icon       :string
#  status     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Price < ApplicationRecord
	mount_uploader :icon, PriceImageUploader
	validates :title, presence: true
  validates_length_of :title, :maximum => 255
  validates :price, presence: true
end
