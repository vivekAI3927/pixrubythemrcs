class ChangeRatingToBeStringInRatings < ActiveRecord::Migration[6.0]
  def up
  	change_column :ratings, :rating, :string
  end

  def down
  	change_column :ratings, :rating, :integer
  end
end
