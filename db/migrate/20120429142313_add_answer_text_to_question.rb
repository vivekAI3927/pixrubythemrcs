class AddAnswerTextToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :answer_text, :text
  end
end
