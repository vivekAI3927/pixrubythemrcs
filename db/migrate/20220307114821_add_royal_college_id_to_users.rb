class AddRoyalCollegeIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :royal_college_id, :string
  end
end
