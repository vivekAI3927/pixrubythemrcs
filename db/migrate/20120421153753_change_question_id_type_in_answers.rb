class ChangeQuestionIdTypeInAnswers < ActiveRecord::Migration[6.0]
  def change
	  execute %q{
	    alter table answers
	    alter column question_id
	    type int using cast(question_id as int)
	  }
  end
end
