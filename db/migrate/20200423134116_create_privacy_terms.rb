class CreatePrivacyTerms < ActiveRecord::Migration[6.0]
  def change
    create_table :privacy_terms do |t|
      t.string :title
      t.text :term_and_condition
      t.text :note
      t.boolean :status

      t.timestamps
    end
  end
end
