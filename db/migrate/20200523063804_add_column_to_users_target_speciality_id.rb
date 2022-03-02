class AddColumnToUsersTargetSpecialityId < ActiveRecord::Migration[6.0]
  def change
  	add_column :users, :target_speciality_id, :integer
  end
end
