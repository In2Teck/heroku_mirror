class AddDificultadToReceta < ActiveRecord::Migration
  def change
    add_column :recetas, :dificultad, :integer
  end
end
