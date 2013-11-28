class GenerateSlugForRecetas < ActiveRecord::Migration
  def change
    add_column :recetas, :slug, :string
    add_index :recetas, :slug, unique: true

    Recipe.reset_column_information
    Recipe.find_each do |r|
      r.save! if r.valid?
    end

  end
end
