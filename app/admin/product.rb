ActiveAdmin.register Product do
  menu parent: "Administracion"
  index do
    column "Titulo", sortable: :titulo do |model|
      link_to model.to_s, [:admin, model]
    end
    column "Count" do |model|
      model.recipes.count
    end
  end
end
