# == Schema Information
#
# Table name: email_formats
#
#  id               :bigint           not null, primary key
#  exam_reminder    :text
#  not_join_message :text
#  paid_message     :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class EmailFormat < ApplicationRecord
end
