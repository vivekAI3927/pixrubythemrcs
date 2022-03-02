class RenamePasswordDigestToUsers < ActiveRecord::Migration[6.0]
  def change
  	remove_column :users, :encrypted_password, :string
  	rename_column :users, :password_digest, :encrypted_password
  end
end
