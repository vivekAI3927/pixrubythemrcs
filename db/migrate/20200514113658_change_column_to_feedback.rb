class ChangeColumnToFeedback < ActiveRecord::Migration[6.0]
  def change
  	remove_column :feedbacks, :review_us
  	remove_column :feedbacks, :recommend_us
  	remove_column :feedbacks, :join_us
  	remove_column :feedbacks, :email
  	add_column :feedbacks, :name, :string
  	add_column :feedbacks, :description, :text
  end
end
