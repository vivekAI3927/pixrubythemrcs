class AddSubscribedExpiredAtToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :subscribed_expired_at, :datetime
  end
end
