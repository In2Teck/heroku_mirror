class AddTagsToRecipe < ActiveRecord::Migration
  def change
    add_column :recetas, :etiquetas, :text
  end
end
