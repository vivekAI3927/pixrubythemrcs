class CreateRecommends < ActiveRecord::Migration[6.0]
  def change
    create_table :recommends do |t|
      t.string :email
      t.text :description

      t.timestamps
    end
  end
end
