# == Schema Information
#
# Table name: reset_password_emails
#
#  id          :bigint           not null, primary key
#  title       :text
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class ResetPasswordEmail < ApplicationRecord
end
