class CreateGrupos < ActiveRecord::Migration
  def change
    create_table :grupos do |t|
      t.string :nombre

      t.timestamps
    end

    create_table :grupos_receta, :id => false do |t|
        t.references :receta
        t.references :grupo
    end
    add_index :grupos_receta, [:grupo_id, :receta_id]
    add_index :grupos_receta, [:receta_id, :grupo_id]

  end
end
