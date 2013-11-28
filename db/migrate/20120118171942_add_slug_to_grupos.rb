class AddSlugToGrupos < ActiveRecord::Migration
  def change
    add_column :grupos, :slug, :string
    add_index :grupos, :slug, unique: true
  end
end
