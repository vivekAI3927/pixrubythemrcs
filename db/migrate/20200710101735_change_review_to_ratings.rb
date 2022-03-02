class ChangeReviewToRatings < ActiveRecord::Migration[6.0]
  def change
  	change_column :ratings, :review, :text
  end
end
