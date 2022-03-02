class AddAnnotationsToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :image_text, :string
    add_column :questions, :image_url, :string
    add_column :questions, :answer_image_text, :string
    add_column :questions, :answer_image_url, :string
  end
end
