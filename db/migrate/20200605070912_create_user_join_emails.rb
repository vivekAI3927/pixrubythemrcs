class CreateUserJoinEmails < ActiveRecord::Migration[6.0]
  def change
    create_table :user_join_emails do |t|
      t.string :subject
      t.text :description

      t.timestamps
    end
  end
end
