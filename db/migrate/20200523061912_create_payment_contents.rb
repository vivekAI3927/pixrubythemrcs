class CreatePaymentContents < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_contents do |t|
      t.text :stripe
      t.text :paypal
      t.text :discount

      t.timestamps
    end
  end
end
