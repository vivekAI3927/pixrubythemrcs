# == Schema Information
#
# Table name: user_memberships
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  membership_id :integer
#  active        :boolean
#  expired_at    :datetime
#  token         :string(255)
#  response      :hstore
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class UserMemberships < ApplicationRecord
	belongs_to :user
	belongs_to :membership

	scope :recently_created, ->  { where(created_at: 1.minutes.ago..DateTime.now) }

  def set_paid
		self.active = true
  end

  def set_failed
		self.active = false
  end
  
end
