class CreatePrices < ActiveRecord::Migration[6.0]
  def change
    create_table :prices do |t|
      t.string :title
      t.string :price
      t.string :icon
      t.boolean :status

      t.timestamps
    end
  end
end
