# == Schema Information
#
# Table name: coupons
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  discount   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  uses       :integer          default(0)
#

class Coupon < ApplicationRecord

  validates_presence_of :name, :discount
  validates_numericality_of :discount
  validates_length_of :name, :maximum => 255

  def increment_coupon_uses
    update_attributes({uses: self.uses += 1})
  end


end
