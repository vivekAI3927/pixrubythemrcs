class ChangeColumnToAbout < ActiveRecord::Migration[6.0]
  def change
  	remove_column :abouts, :description_one
  	remove_column :abouts, :description_two
  	remove_column :abouts, :description_three
  	add_column :abouts, :description, :text
  end
end
