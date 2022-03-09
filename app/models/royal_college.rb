class RoyalCollege < ApplicationRecord
  has_many :users
  validates :name, presence: true
  validates_length_of :name, :maximum => 255
end
