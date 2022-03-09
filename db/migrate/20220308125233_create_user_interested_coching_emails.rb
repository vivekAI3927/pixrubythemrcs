class CreateUserInterestedCochingEmails < ActiveRecord::Migration[6.0]
  def change
    create_table :user_interested_coching_emails do |t|
      t.string :subject
      t.text :description

      t.timestamps
    end
  end
end
