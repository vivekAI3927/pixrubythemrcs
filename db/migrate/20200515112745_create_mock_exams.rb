class CreateMockExams < ActiveRecord::Migration[6.0]
  def change
    create_table :mock_exams do |t|
      t.text :description

      t.timestamps
    end
  end
end
