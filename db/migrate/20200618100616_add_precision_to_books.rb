class AddPrecisionToBooks < ActiveRecord::Migration[6.0]
  def change
  	 change_column :books, :cost, :decimal, :precision => 8, :scale => 2
  end
end
