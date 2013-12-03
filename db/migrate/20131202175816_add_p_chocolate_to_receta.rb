class AddPChocolateToReceta < ActiveRecord::Migration
  def change
    add_column :recetas, :p_chocolate, :boolean, :default => false

  end
end
