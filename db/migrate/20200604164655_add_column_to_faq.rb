class AddColumnToFaq < ActiveRecord::Migration[6.0]
  def change
  	add_column :faqs, :rank, :integer
  end
end
