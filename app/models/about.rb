# == Schema Information
#
# Table name: abouts
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#  image       :string
#
class About < ApplicationRecord
	mount_uploader :image, AboutImageUploader
end

