class RenameRecetasToRecipes < ActiveRecord::Migration
  def change
    rename_table :grupos_receta, :grupos_recipes
    rename_column :grupos_recipes, :receta_id, :recipe_id
    rename_table :receta_utensilios, :recipes_utensilios
    rename_column :recipes_utensilios, :receta_id, :recipe_id
  end
end
