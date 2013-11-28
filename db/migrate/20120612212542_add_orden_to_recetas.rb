class AddOrdenToRecetas < ActiveRecord::Migration
  def change
    add_column :recetas, :orden, :integer
    add_index :recetas, :orden
  end
end
