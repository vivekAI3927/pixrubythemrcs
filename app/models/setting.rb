# == Schema Information
#
# Table name: settings
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  price      :decimal(8, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Setting < ApplicationRecord

  validates :name, presence: true
  validates :price, presence: true
  validates_length_of :name, :maximum => 255

end
