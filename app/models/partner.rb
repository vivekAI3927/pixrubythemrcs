class Partner < ApplicationRecord

	# mount_uploader :image, PartnerImageUploader
	validates :description, presence: true
end
