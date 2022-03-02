class CreatePartnerMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :partner_members do |t|
      t.string :name
      t.string :title
      t.string :image
      t.text :bio
      t.integer :position

      t.timestamps
    end
  end
end
