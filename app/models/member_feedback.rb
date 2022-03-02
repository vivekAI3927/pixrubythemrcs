# == Schema Information
#
# Table name: member_feedbacks
#
#  id          :bigint           not null, primary key
#  section_one :text
#  section_two :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class MemberFeedback < ApplicationRecord
end
