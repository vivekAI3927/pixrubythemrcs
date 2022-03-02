class CreatePartaSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :parta_settings do |t|
      t.text :banner_text
      t.string :title

      t.timestamps
    end
  end
end
