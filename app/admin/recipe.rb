# encoding: utf-8
ActiveAdmin.register Recipe do
  # scope :featured
  scope :no_modificado
  scope :modificado
  scope :sin_foto
  scope :con_foto

  filter :id
  filter :titulo
  filter :tiempo
  filter :ingredientes
  filter :preparacion
  filter :dificultad
  filter :p_chocolate, :as => :select

  # controller do 
  #   def update
  #     # raise self.inspect
  #   end
  # end

  index do
    column "Id" do |model|
      model.id.to_s
    end
    column "Imagen" do |model|
      link_to image_tag("http://phillybeta.outofthebox.mx/recetas/clasico/#{model.imagen}.jpg", {width: 100}), edit_admin_recipe_path(model.id)
    end
    column "Titulo", sortable: :titulo do |model|
      link_to model.to_s, edit_admin_recipe_path(model.id)
    end
  end 

  action_item :only => :index do
    link_to 'Download XML', "recipes/download_xml.xml", :target => "_blank" 
  end

  collection_action :download_xml do
    @recipies = Recipe.all
    respond_to do |format|
      format.xml { render xml: @recipies }
    end
  end

  show do |model|
    h2 model.titulo
    attributes_table_for model do
      row "Imagen" do
        image_tag "http://phillybeta.outofthebox.mx/recetas/clasico/#{model.imagen}.jpg"
      end
      if model.featured?
        row "Featured" do
          "Receta destacada"
        end
      end
      row "Grupos" do
        model.grupos.map(&:to_s).join(', ')
      end
      row "Tipos de platillo" do
        model.tipos_platillo.join(', ')
      end
      row :tiempo
      row :porciones
      # row :puntuacion
      row :product

      if model.videoreceta?
        row "Videoreceta" do
          "Es videoreceta"
        end
      end
      row "Ingredientes" do
        simple_format model.ingredientes
      end
      row "Preparacion" do
        simple_format model.preparacion
      end
      row "Tips" do
        simple_format model.tips
      end

    end
  end

  form partial: 'form'
end
