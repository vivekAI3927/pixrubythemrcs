class CreatePartaCategoryStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :parta_category_statuses do |t|
      t.integer :parta_user_id
      t.integer :parta_category_id
      t.string :status

      t.timestamps
    end
  end
end
