class CreateTargetSpecialities < ActiveRecord::Migration[6.0]
  def change
    create_table :target_specialities do |t|
      t.string :name

      t.timestamps
    end
  end
end
