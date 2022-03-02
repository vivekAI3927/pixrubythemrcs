class Change < ActiveRecord::Migration[6.0]
  def change
  	remove_column :home_logo_banners, :title
  	add_column :home_logo_banners, :first_title, :string
  	add_column :home_logo_banners, :second_title, :string
  end
end
