class AddForeignKeyConstraints < ActiveRecord::Migration[6.0]
  def change
  	add_foreign_key :stations, :categories
  	add_foreign_key :answers, :questions
  	add_foreign_key :questions, :stations
    add_foreign_key :station_statuses, :users
  	add_foreign_key :station_statuses, :stations
    add_foreign_key :survey_answers, :attempts
    add_foreign_key :survey_answers, :questions
    add_foreign_key :survey_options, :questions
    add_foreign_key :user_memberships, :users
    add_foreign_key :user_memberships, :memberships
  end
end
