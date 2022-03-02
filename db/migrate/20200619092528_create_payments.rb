class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.references :user
      t.string :status, limit: 255
      t.string :provider, limit: 255
      t.json :response

      t.timestamps
    end
  end
end
