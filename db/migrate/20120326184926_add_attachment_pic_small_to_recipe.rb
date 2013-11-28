class AddAttachmentPicSmallToRecipe < ActiveRecord::Migration
  def self.up
    add_column :recetas, :pic_small_file_name, :string
    add_column :recetas, :pic_small_content_type, :string
    add_column :recetas, :pic_small_file_size, :integer
    add_column :recetas, :pic_small_updated_at, :datetime
  end

  def self.down
    remove_column :recetas, :pic_small_file_name
    remove_column :recetas, :pic_small_content_type
    remove_column :recetas, :pic_small_file_size
    remove_column :recetas, :pic_small_updated_at
  end
end
