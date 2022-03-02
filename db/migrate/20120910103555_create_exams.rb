class CreateExams < ActiveRecord::Migration[6.0]
  def change
    create_table :exams do |t|
      t.integer :user_id
      t.integer :current_station
      t.text :stations

      t.timestamps
    end
  end
end
