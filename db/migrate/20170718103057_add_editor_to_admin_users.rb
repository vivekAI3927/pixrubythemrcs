class AddEditorToAdminUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_users, :editor, :boolean, default: false
  end
end
