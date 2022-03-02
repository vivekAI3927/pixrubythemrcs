class AddColumnToAdminSuperAdmin < ActiveRecord::Migration[6.0]
  def change
  	add_column :admins, :super_admin, :boolean, default: false
  end
end
