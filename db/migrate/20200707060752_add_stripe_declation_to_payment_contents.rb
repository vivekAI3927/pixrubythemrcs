class AddStripeDeclationToPaymentContents < ActiveRecord::Migration[6.0]
  def change
    add_column :payment_contents, :stripe_declaration, :text
  end
end
