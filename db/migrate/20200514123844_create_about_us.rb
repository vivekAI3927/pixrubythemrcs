class CreateAboutUs < ActiveRecord::Migration[6.0]
  def change
    create_table :abouts do |t|
      t.text :description_one
      t.text :description_two
      t.text :description_three

      t.timestamps
    end
  end
end
