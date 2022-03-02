class CreatePartaCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :parta_categories do |t|
      t.string :name
      t.text :description
      t.references :parta_category
      t.string :image
      t.integer :position
      t.string :slug, uniq: true
      t.timestamps
    end
  end
end
