class MarkAllAsNotMigrated < ActiveRecord::Migration
  def change
    Receta.find_each do |receta|
      receta.migrado = false
      receta.aprobado = false
      receta.save!
    end
  end
end
