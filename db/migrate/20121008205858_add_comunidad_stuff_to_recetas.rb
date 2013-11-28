class AddComunidadStuffToRecetas < ActiveRecord::Migration
  def change
    add_column :recetas, :comunidad_autor, :string
  end
end
