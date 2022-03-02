class CreateUserMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :user_memberships do |t|
      t.integer :user_id
      t.integer :membership_id
      t.boolean :active
      t.datetime :expired_at
      t.string :token
      t.hstore :response

      t.timestamps
    end
  end
end
