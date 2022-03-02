# frozen_string_literal: true

class DeviseCreatePartaUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :parta_users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
       t.integer  :sign_in_count, default: 0, null: false
       t.datetime :current_sign_in_at
       t.datetime :last_sign_in_at
       t.inet     :current_sign_in_ip
       t.inet     :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
       t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
       t.string   :unlock_token # Only if unlock strategy is :email or :both
       t.datetime :locked_at

			
      t.timestamps null: false
			
			## OUR OWN FIELD
			t.string :name, :limit => 255
			t.date :target_exam_date
			t.string :country, :limit => 255
			t.integer :target_speciality_id
    end

    add_index :parta_users, :email,                unique: true
    add_index :parta_users, :reset_password_token, unique: true
    # add_index :parta_users, :confirmation_token,   unique: true
    add_index :parta_users, :unlock_token,         unique: true
		
    execute "alter table parta_users add constraint fk_parta_users_target_speciality_id foreign key (target_speciality_id) references target_specialities(id) ON DELETE SET NULL"
		add_index :parta_users, :target_speciality_id
  end
end
