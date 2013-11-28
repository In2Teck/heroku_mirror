class MobileController < ApplicationController
  def index
  end

  def buscar
    r = Recipe.busqueda(params[:busqueda][:q]).order("recetas.tiempo, recetas.id").page(params[:page]).per(24)
    @recetas = r.publicado
    render :recetas
  end

  def recetas
    r = Recipe.order("recetas.orden, recetas.tiempo, recetas.id").page(params[:page]).per(24)

    f = []
    case params[:categoria]
      when 'sopas'
        f << 'p_sopa'
      when 'platos_fuertes'
        f << 'p_carne'
        f << 'p_cerdo'
        f << 'p_aves'
        f << 'p_pescado'
      when 'postres'
        f << 'p_postre'
      when 'botanas'
        f << 'p_botana'
      when 'pasta'
        f << 'p_pasta'
    end
    
    @recetas = r.porplatillo(f).publicado
  end
  
 	
 	
 	
 	def recetaslista
    r = Recipe.order("recetas.orden, recetas.tiempo, recetas.id").page(params[:page]).per(24)

    f = []
    case params[:categoria]
      when 'sopas'
        f << 'p_sopa'
      when 'platos_fuertes'
        f << 'p_carne'
        f << 'p_cerdo'
        f << 'p_aves'
        f << 'p_pescado'
      when 'postres'
        f << 'p_postre'
      when 'botanas'
        f << 'p_botana'
      when 'pasta'
        f << 'p_pasta'
    end
    
    @recetas = r.porplatillo(f).publicado
  end


  def catmobile
  
  end
  
end
