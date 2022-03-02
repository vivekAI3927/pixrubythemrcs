class CreateMockExamTexts < ActiveRecord::Migration[6.0]
  def change
    create_table :mock_exam_texts do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
