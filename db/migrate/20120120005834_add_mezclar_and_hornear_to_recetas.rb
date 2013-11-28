class AddMezclarAndHornearToRecetas < ActiveRecord::Migration
  def change
    r = Recipe.new
    add_column :recetas, :t_mezclar, :boolean unless r.respond_to? :t_mezclar
    add_column :recetas, :t_hornear, :boolean unless r.respond_to? :t_hornear
  end
end
