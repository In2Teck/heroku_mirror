class AddIndexToRecipeFoto < ActiveRecord::Migration
  def change
    add_index(:recetas, :recipe_photo)
  end
end
