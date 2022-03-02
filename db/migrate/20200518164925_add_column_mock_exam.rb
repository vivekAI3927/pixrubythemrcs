class AddColumnMockExam < ActiveRecord::Migration[6.0]
  def change
  	add_column :mock_exams, :title, :string
  end
end
