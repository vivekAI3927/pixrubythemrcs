class ChangeLocationToMemberships < ActiveRecord::Migration[6.0]
  def up
    change_column :memberships, :location, :text, array: true, default: [], using: "(string_to_array(location, ','))"
  end

  def down
    change_column :memberships, :location, :string
  end
end
