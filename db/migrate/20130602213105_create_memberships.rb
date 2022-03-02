class CreateMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :memberships do |t|
      t.integer :length
      t.decimal :price, precision: 8, scale: 2
      t.boolean :available, default: true

      t.timestamps
    end
  end
end
