class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.integer :question_id
      t.integer :station_id
      t.integer :rating
      t.string :review
      t.integer :user_id

      t.timestamps
    end
  end
end
