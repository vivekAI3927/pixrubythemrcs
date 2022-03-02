class AddNameToRecommends < ActiveRecord::Migration[6.0]
  def change
  	add_column :recommends, :name, :string
  end
end
