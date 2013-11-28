class GenerateSlugForGrupos < ActiveRecord::Migration
  def change
    Grupo.find_each(&:save)
  end
end
