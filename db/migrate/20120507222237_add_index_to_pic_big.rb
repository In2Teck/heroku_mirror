class AddIndexToPicBig < ActiveRecord::Migration
  def change
    add_index(:recetas, :pic_big_file_name)
  end
end
