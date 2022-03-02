class AddIndexToMissingModels < ActiveRecord::Migration[6.0]
  def change
  	add_index :answers, :question_id
  	add_index :comments, :commentable_id
  	add_index :exams, :user_id
  	add_index :questions, :station_id
  	add_index :ratings, :station_id
  	add_index :ratings, :question_id
  	add_index :station_statuses, :user_id
  	add_index :station_statuses, :station_id
  	add_index :stations, :category_id
    add_index :survey_answers, :attempt_id
    add_index :survey_answers, :question_id
    add_index :survey_answers, :option_id
    add_index :survey_attempts, :survey_id
    add_index :survey_attempts, :participant_id
    add_index :survey_options, :question_id
    add_index :survey_questions, :survey_id
    add_index :user_memberships, :user_id
    add_index :user_memberships, :membership_id




  end
end
