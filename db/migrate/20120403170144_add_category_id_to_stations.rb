class AddCategoryIdToStations < ActiveRecord::Migration[6.0]
  def change
    add_column :stations, :category_id, :integer
  end
end
