class AddSentExamReminderToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :sent_exam_reminder, :boolean, default: false
  end
end
