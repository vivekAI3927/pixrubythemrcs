class RemoteRatingToRatings < ActiveRecord::Migration[6.0]
  def change
  	remove_column :ratings, :rating
  end
end
