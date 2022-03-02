class CreateEmailFormats < ActiveRecord::Migration[6.0]
  def change
    create_table :email_formats do |t|
      t.text :exam_reminder
      t.text :not_join_message
      t.text :paid_message

      t.timestamps
    end
  end
end
