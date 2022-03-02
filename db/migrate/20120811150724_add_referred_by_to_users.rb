class AddReferredByToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :referred_by, :string
  end
end
