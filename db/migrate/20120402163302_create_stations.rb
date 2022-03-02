class CreateStations < ActiveRecord::Migration[6.0]
  def change
    create_table :stations do |t|
      t.string :title
      t.text :scenario_text
      t.boolean :trial

      t.timestamps
    end
  end
end
