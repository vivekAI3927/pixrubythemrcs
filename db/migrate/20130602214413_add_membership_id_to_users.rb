class AddMembershipIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :membership_id, :integer
    add_index :users, :membership_id
  end
end
