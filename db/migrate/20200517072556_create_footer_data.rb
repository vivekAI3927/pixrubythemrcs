class CreateFooterData < ActiveRecord::Migration[6.0]
  def change
    create_table :footer_records do |t|
      t.string :copyright
      t.string :all_right_reserved

      t.timestamps
    end
  end
end
