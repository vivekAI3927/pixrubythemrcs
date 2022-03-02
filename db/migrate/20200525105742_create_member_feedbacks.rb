class CreateMemberFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :member_feedbacks do |t|
      t.text :section_one
      t.text :section_two

      t.timestamps
    end
  end
end
