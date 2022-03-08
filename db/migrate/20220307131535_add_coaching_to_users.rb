class AddCoachingToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :coaching, :boolean
  end
end
