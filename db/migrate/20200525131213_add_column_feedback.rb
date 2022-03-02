class AddColumnFeedback < ActiveRecord::Migration[6.0]
  def change
  	add_column :feedbacks, :star_rating, :string
  end
end
