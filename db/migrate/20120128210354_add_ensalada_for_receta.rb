class AddEnsaladaForReceta < ActiveRecord::Migration
  def change
    add_column :recetas, :t_ensalada, :boolean, default: false
  end
end
