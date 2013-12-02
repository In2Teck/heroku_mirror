class AddPChocolateToReceta < ActiveRecord::Migration
  def change
    add_column :recetas, :p_chocolate, :boolean

  end
end
