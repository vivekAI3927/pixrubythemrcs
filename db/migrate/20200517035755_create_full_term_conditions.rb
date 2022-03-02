class CreateFullTermConditions < ActiveRecord::Migration[6.0]
  def change
    create_table :full_term_conditions do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
