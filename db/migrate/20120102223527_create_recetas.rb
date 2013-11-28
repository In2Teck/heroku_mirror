class CreateRecetas < ActiveRecord::Migration
  def change
    create_table :recetas do |t|
      t.string :titulo
      t.string :categoria
      t.boolean :receta_dia
      t.boolean :receta_facil
      t.boolean :receta_especial
      t.boolean :receta_temporada
      t.boolean :saludable
      t.boolean :receta_postre
      t.string :imagen
      t.integer :tiempo
      t.string :porcion
      t.text :ingredientes
      t.text :preparacion
      t.text :tips
      t.string :puntuacion
      t.boolean :video
      t.string :tipo_platillo
      t.boolean :p_entrada
      t.boolean :p_botana
      t.boolean :p_ensalada
      t.boolean :p_guarnicion
      t.boolean :p_sopa
      t.boolean :p_platofuerte
      t.boolean :p_aves
      t.boolean :p_carne
      t.boolean :p_pasta
      t.boolean :p_pescado
      t.boolean :p_otros
      t.boolean :p_light
      t.boolean :p_postre
      t.integer :product_id
      t.boolean :featured

      t.timestamps
    end
  end
end
