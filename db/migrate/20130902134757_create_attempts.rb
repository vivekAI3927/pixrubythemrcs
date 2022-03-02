class CreateAttempts < ActiveRecord::Migration[6.0]
  def change
    create_table :attempts do |t|
      t.belongs_to :user
      t.belongs_to :station
      t.boolean :started, default: false
      t.boolean :completed, default: false

      t.timestamps
    end
    # add_index :attempts, :user_id
    # add_index :attempts, :station_id
  end
end
