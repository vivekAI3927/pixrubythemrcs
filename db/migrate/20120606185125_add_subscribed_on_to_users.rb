class AddSubscribedOnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :subscribed_on, :date
  end
end
