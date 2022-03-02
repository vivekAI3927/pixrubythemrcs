class CreateResetPasswordEmails < ActiveRecord::Migration[6.0]
  def change
    create_table :reset_password_emails do |t|
      t.text :title
      t.text :description

      t.timestamps
    end
  end
end
