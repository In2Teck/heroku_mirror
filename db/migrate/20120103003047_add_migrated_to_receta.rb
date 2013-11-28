class AddMigratedToReceta < ActiveRecord::Migration
  def change
    add_column :recetas, :migrado, :boolean
    add_column :recetas, :desayuno, :boolean
    add_column :recetas, :p_cerdo, :boolean
    add_column :recetas, :aprobado, :boolean
    add_column :recetas, :t_relleno, :boolean
    add_column :recetas, :t_salsa, :boolean
    add_column :recetas, :t_licuadora, :boolean
    add_column :recetas, :t_sarten, :boolean
  end
end
