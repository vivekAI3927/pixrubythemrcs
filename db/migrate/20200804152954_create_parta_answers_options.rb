class CreatePartaAnswersOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :parta_answers_options do |t|
      t.integer :question_id
      t.integer :user_id
      t.integer :answer_id
      t.string :flag

      t.timestamps
    end
  end
end
