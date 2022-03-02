class AddStatusToMembership < ActiveRecord::Migration[6.0]
  def change
    add_column :memberships, :status, :string, limit: 255, default: 'create'
  end
end
