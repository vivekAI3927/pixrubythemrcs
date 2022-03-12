class AddLocationToMembership < ActiveRecord::Migration[6.0]
  def change
    add_column :memberships, :location, :string
  end
end
