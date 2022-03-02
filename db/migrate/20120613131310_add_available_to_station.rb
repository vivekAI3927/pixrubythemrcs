class AddAvailableToStation < ActiveRecord::Migration[6.0]
  def change
    add_column :stations, :available, :boolean, default: true
  end
end
