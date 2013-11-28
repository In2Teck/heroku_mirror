class AddBigPhotoToRecetas < ActiveRecord::Migration
  def change
    add_column :recetas, :recipe_photo, :string
  end
end
