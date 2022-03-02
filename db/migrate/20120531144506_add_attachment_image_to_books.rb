class AddAttachmentImageToBooks < ActiveRecord::Migration[6.0]
  def self.up
    add_column :books, :image_file_name, :string
    add_column :books, :image_content_type, :string
    add_column :books, :image_file_size, :integer
    add_column :books, :image_updated_at, :datetime
  end

  def self.down
    remove_column :books, :image_file_name
    remove_column :books, :image_content_type
    remove_column :books, :image_file_size
    remove_column :books, :image_updated_at
  end
end
