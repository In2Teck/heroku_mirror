class CreateMedios < ActiveRecord::Migration
  def change
    create_table :medios do |t|
      t.string :nombre

      t.timestamps
    end

    create_table :receta_medios, :id => false do |t|
        t.references :receta
        t.references :medio
    end
    add_index :receta_medios, [:medio_id, :receta_id]
    add_index :receta_medios, [:receta_id, :medio_id]

    ["Facebook", "Twitter", "YouTube"].each do |r|
      Medio.create :nombre => r
    end
  end
end
