class AddPorcionesToRecetas < ActiveRecord::Migration
  def up
    add_column :recetas, :porciones, :integer

    # asume que las porciones estan en el formato n porciones
    Receta.find_each do |receta|
      porcion_i = receta.porcion.strip.split(' ')[0].to_i
      receta.update_attribute(:porciones, porcion_i)
    end

    remove_column :recetas, :porcion
  end

  def down
    add_column :recetas, :porcion, :string
    Receta.find_each do |receta|
      receta.update_attribute(:porcion, "#{receta.porciones.to_s} ")
    end
    remove_column :recetas, :porciones
  end
end
