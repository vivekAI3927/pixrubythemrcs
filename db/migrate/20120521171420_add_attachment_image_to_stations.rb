class AddAttachmentImageToStations < ActiveRecord::Migration[6.0]
  def self.up
    add_column :stations, :image_file_name, :string
    add_column :stations, :image_content_type, :string
    add_column :stations, :image_file_size, :integer
    add_column :stations, :image_updated_at, :datetime
    add_column :stations, :videoId, :string
  end

  def self.down
    remove_column :stations, :image_file_name
    remove_column :stations, :image_content_type
    remove_column :stations, :image_file_size
    remove_column :stations, :image_updated_at
    remove_column :stations, :videoId
  end
end
