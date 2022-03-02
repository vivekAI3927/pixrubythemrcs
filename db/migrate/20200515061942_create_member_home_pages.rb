class CreateMemberHomePages < ActiveRecord::Migration[6.0]
  def change
    create_table :member_home_pages do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
