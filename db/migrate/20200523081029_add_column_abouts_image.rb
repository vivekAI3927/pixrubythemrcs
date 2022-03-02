class AddColumnAboutsImage < ActiveRecord::Migration[6.0]
  def change
  	add_column :abouts, :image, :string
  end
end
