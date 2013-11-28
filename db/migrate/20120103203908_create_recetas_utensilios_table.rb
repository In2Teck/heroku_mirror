class CreateRecetasUtensiliosTable < ActiveRecord::Migration
  def change
    create_table :receta_utensilios, :id => false do |t|
        t.references :receta
        t.references :utensilio
    end
    add_index :receta_utensilios, [:receta_id, :utensilio_id]
    add_index :receta_utensilios, [:utensilio_id, :receta_id]
  end
end
