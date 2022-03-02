class AddTargetExamDateToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :target_exam_date, :date
  end
end