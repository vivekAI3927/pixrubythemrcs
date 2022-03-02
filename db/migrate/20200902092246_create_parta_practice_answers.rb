class CreatePartaPracticeAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :parta_practice_answers do |t|
      t.integer :question_id
      t.integer :user_id
      t.string :answe
      t.integer :answer_id

      t.timestamps
    end
  end
end
