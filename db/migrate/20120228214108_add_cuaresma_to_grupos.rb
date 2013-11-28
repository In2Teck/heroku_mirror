class AddCuaresmaToGrupos < ActiveRecord::Migration
  def change
    Grupo.create  :nombre => 'Cuaresma' 
  end  
end
