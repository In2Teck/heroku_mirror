class AddSlugToUtensilio < ActiveRecord::Migration
  def change
    add_column :utensilios, :slug, :string
    add_index :utensilios, :slug, unique: true
  end
end
