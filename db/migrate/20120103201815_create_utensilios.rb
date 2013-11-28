class CreateUtensilios < ActiveRecord::Migration
  def change
    create_table :utensilios do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
