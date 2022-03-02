class CreateCommunityCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :community_codes do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
