class AddAvailableToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :available, :boolean
  end
end
