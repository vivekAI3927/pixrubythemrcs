class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks do |t|
      t.text :review_us
      t.text :recommend_us
      t.text :join_us
      t.string :email
      t.boolean :status

      t.timestamps
    end
  end
end
