class CreateStationStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :station_statuses do |t|
      t.integer :user_id
      t.integer :station_id
      t.string :status

      t.timestamps
    end
  end
end
