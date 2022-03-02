class AddSecondTypeToStations < ActiveRecord::Migration[6.0]
  def change
    add_column :stations, :markscheme, :text
    add_column :stations, :actor_brief, :text
    add_column :stations, :exam_brief, :text
    add_column :stations, :cheatsheet, :text
  end
end
