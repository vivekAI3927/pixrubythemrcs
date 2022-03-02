class CreatePartaAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :parta_answers do |t|
      t.references :parta_question, null: false, foreign_key: true
      t.text :content
      t.boolean :correct

      t.timestamps
    end
  end
end
