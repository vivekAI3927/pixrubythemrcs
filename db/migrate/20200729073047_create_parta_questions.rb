class CreatePartaQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :parta_questions do |t|
        t.text :content
	    t.integer "position"
	    t.integer "parta_category_id"
	    t.string "image", limit: 255
	    t.text "answer_text"
	    t.string "image_text", limit: 255
	    t.string "answer_image", limit: 255
	    t.index ["parta_category_id"], name: "index_questions_on_parta_category_id"

      t.timestamps
    end
  end
end



