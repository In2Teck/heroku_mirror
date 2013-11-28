class AddVideoUrlToRecetas < ActiveRecord::Migration
  def change
    add_column :recetas, :video_url, :string
  end
end
