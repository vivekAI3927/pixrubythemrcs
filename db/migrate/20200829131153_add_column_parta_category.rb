class AddColumnPartaCategory < ActiveRecord::Migration[6.0]
  def change
  	add_column :parta_categories, :flag, :string, default: "TO-DO"
  end
end
