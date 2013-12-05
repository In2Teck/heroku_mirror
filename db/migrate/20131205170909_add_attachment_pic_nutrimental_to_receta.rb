class AddAttachmentPicNutrimentalToReceta < ActiveRecord::Migration
  def self.up
    add_column :recetas, :pic_nutrimental_file_name, :string
    add_column :recetas, :pic_nutrimental_content_type, :string
    add_column :recetas, :pic_nutrimental_file_size, :integer
    add_column :recetas, :pic_nutrimental_updated_at, :datetime
  end

  def self.down
    remove_column :recetas, :pic_nutrimental_file_name
    remove_column :recetas, :pic_nutrimental_content_type
    remove_column :recetas, :pic_nutrimental_file_size
    remove_column :recetas, :pic_nutrimental_updated_at
  end
end
