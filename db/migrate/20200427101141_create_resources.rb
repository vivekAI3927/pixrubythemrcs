class CreateResources < ActiveRecord::Migration[6.0]
  def change
    create_table :resources do |t|
      t.string :title
      t.text :description
      t.boolean :available

      t.timestamps
    end
  end
end
