class UserInterestedCochingEmail < ApplicationRecord
  validates :subject, presence: true
  validates_length_of :subject, :maximum => 255
end
