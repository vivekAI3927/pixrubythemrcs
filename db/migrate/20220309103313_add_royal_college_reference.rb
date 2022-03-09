class AddRoyalCollegeReference < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :royal_college_id, :string
    add_reference :users, :royal_college, index: true
  end
end
