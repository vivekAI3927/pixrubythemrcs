class CreateQuestionCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :question_categories do |t|
      t.string :title
      t.integer :no_of_question

      t.timestamps
    end
  end
end
