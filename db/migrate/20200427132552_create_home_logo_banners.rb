class CreateHomeLogoBanners < ActiveRecord::Migration[6.0]
  def change
    create_table :home_logo_banners do |t|
      t.string :title
      t.text :description
      t.string :logo
      t.string :banner

      t.timestamps
    end
  end
end
