class CreateAdminAccesses < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_accesses do |t|
      t.integer :admin_id
      t.string :allow_model_name, default: [], array: true
      t.boolean :allow_access
      t.timestamps
    end
  end
end
