# encoding: utf-8
class CreateUsos < ActiveRecord::Migration
  def change
    create_table :usos do |t|
      t.string :nombre

      t.timestamps
    end

    create_table :receta_usos, :id => false do |t|
        t.references :receta
        t.references :uso
    end
    add_index :receta_usos, [:uso_id, :receta_id]
    add_index :receta_usos, [:receta_id, :uso_id]

    ["Página Web", "Empaques", "Recetarios", "Clases CGK", "Food Service", "Recetas Beta", "Recetas Ya", "Recetas Comunidad", "Recetas Display"].each do |r|
      Uso.create :nombre => r
    end
  end
end
