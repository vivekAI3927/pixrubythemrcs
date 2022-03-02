# == Schema Information
#
# Table name: payment_contents
#
#  id         :bigint           not null, primary key
#  stripe     :text
#  paypal     :text
#  discount   :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PaymentContent < ApplicationRecord
end
