class AddLastQuestionIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :last_question_id, :integer
  end
end
