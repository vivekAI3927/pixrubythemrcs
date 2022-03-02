class AddFlagToStations < ActiveRecord::Migration[6.0]
  def change
    add_column :stations, :flag, :string, default: "TO-DO"
  end
end
