class AddPositionToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :position, :integer
  end
end
