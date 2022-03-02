class AddCouponNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :coupon_name, :string
  end
end
