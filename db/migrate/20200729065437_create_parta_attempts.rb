class CreatePartaAttempts < ActiveRecord::Migration[6.0]
  def change
    create_table :parta_attempts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :parta_category, null: false, foreign_key: true
      t.boolean :started
      t.boolean :completed

      t.timestamps
    end
  end
end
