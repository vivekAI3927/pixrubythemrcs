class PartnerMember < ApplicationRecord
	default_scope { order('position ASC') }

	mount_uploader :image, MemberImageUploader
	validates :name, presence: true
  validates_length_of :name, :maximum => 255
  validates_length_of :title, :maximum => 255
  validates :bio, presence: true
  validates :image, presence: true
  validates :position, presence: true
end
