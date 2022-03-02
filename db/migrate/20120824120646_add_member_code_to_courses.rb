class AddMemberCodeToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :member_code, :string
  end
end
