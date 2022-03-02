# == Schema Information
#
# Table name: user_join_emails
#
#  id          :bigint           not null, primary key
#  subject     :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class UserJoinEmail < ApplicationRecord

	validates :subject, presence: true
  validates_length_of :subject, :maximum => 255
end
