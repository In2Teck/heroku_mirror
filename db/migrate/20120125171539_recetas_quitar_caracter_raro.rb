class RecetasQuitarCaracterRaro < ActiveRecord::Migration
  # Usamos update_column para no pasar los registros a migrados, además de saltar la validación
  def change
    Recipe.find_each do |r|
      r.update_column :ingredientes, r.ingredientes.gsub(/(\u0095)/, '')
    end
  end
end
