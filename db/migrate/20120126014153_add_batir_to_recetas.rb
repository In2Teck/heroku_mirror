class AddBatirToRecetas < ActiveRecord::Migration
  def change
    add_column :recetas, :t_batir, :boolean, default: false

  end
end
