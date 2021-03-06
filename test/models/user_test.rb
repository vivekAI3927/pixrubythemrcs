# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  email                  :string(255)
#  encrypted_password     :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  subscribed_on          :date
#  referred_by            :string(255)
#  coupon_name            :string(255)
#  country                :string(255)
#  sent_exam_reminder     :boolean          default(FALSE)
#  membership_id          :integer
#  last_question_id       :integer
#  target_exam_date       :date
#  authentication_token   :string(255)
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  remember_created_at    :datetime
#  target_speciality_id   :integer
#
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
