class CreateAboutUsImages < ActiveRecord::Migration[6.0]
  def change
    create_table :about_us_images do |t|
      t.string :image

      t.timestamps
    end
  end
end
