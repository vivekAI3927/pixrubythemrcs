class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :name
      t.text :description
      t.string :link
      t.decimal :cost

      t.timestamps
    end
  end
end
