ActiveAdmin.register Grupo do

  menu parent: "Administracion"
  index do
    column "Nombre" do |model|
      link_to model.to_s, edit_admin_grupo_path(model.id)
    end
    column "Recetas" do |model|
      model.recipes.map do |receta|
        a href: admin_recipe_path(receta.id) do
          receta.to_s
        end
      end
    end
  end

  show do |model|
    h2 model.to_s
    attributes_table_for model do
      row "Recetas" do
        if model.recipes.blank?
          "Ninguna aun"
        else
          model.recipes.map do |receta|
            a href: admin_recipe_path(receta.id) do
              receta.to_s
            end
          end
          " " # que regrese un espacio, de otra forma regresa un array
        end
      end
    end
  end

  form do |f|
    f.inputs 'Descripcion' do
      f.input :nombre
      # agregar imagen
    end

    f.inputs 'Recetas' do
      f.input :recipes, as: :check_boxes
    end

    f.buttons
  end
  
  
  
end