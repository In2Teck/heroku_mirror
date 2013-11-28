# encoding: utf-8

class RecetaController < ApplicationController
  before_filter do
    @recetas_activo = true
  end
	respond_to :html, :json
  def index
    r = Recipe.order("recetas.orden, recetas.tiempo, recetas.id").page(params[:page]).per(24)

    case params[:filtro]
      when /(^grupo-)/
        g = params[:filtro].sub(/^grupo-(.*)/){ $1 }
        r = r.porgrupo(g)
      when /(^tutorial-)/
        t = params[:filtro].sub(/^tutorial-(.*)/){ $1 }
        case t
          when 'rellenar'
            f = 't_relleno'
            video_tutorial = {:titulo => 'Agrega Philadelphia® como Relleno', :img_url => 'tutorial-rellenar.jpg', :video_url => 'tutorial-rellenar.mp4'}
          when 'calentar'
            f = 't_sarten'
            video_tutorial = {:titulo => 'Agrega Philadelphia® en el sartén', :img_url => 'tutorial-calentar.jpg', :video_url => 'tutorial-calentar.mov'}
          when 'licuar'
            f = 't_licuadora'
            video_tutorial = {:titulo => 'Integra Philadelphia® en la licuadora', :img_url => 'tutorial-licuar.jpg', :video_url => 'tutorial-licuar.mov'}
          when 'mezclar'
            f = 't_mezclar'
          when 'hornear'
            f = 't_hornear'
          when 'batir'
            f = 't_batir'
        end
        r = r.portutorial(f) if f
        @video_tutorial = video_tutorial unless video_tutorial.blank?

      when /(^platillo-)/
        p = params[:filtro].sub(/^platillo-(.*)/){ $1 }
        case p
          when 'desayuno'
            f = 'desayuno'
          when 'sopa'
            f = 'p_sopa'
          when 'entrada'
            f = 'p_entrada'
          when 'carne'
            f = 'p_carne'
          when 'cerdo'
            f = 'p_cerdo'
          when 'postre'
            f = 'p_postre'
          when 'botana'
            f = 'p_botana'
          when 'pollo'
            f = 'p_aves'
          when 'pescado'
            f = 'p_pescado'
          when 'pasta'
            f = 'p_pasta'
          when 'ensalada'
            f = 'p_ensalada'
        end

        r = r.porplatillo(f) if f
    end

    case params[:tiempo].to_i
      when 1
        r = r.portiempo(0..20)
      when 2
        r = r.portiempo(21..40)
      when 3
        r = r.portiempo(41..60)
      when 4
        r = r.portiempo(60..1000)
    end

    @recetas = r.publicado

    @porgrupo = Grupo.all
  end

 def service
    r = Recipe.order("recetas.orden, recetas.tiempo, recetas.id").page(params[:page]).per(1000)

    case params[:filtro]
      when /(^grupo-)/
        g = params[:filtro].sub(/^grupo-(.*)/){ $1 }
        r = r.porgrupo(g)
      when /(^tutorial-)/
        t = params[:filtro].sub(/^tutorial-(.*)/){ $1 }
        case t
          when 'rellenar'
            f = 't_relleno'
            video_tutorial = {:titulo => 'Agrega Philadelphia® como Relleno', :img_url => 'tutorial-rellenar.jpg', :video_url => 'tutorial-rellenar.mp4'}
          when 'calentar'
            f = 't_sarten'
            video_tutorial = {:titulo => 'Agrega Philadelphia® en el sartén', :img_url => 'tutorial-calentar.jpg', :video_url => 'tutorial-calentar.mov'}
          when 'licuar'
            f = 't_licuadora'
            video_tutorial = {:titulo => 'Integra Philadelphia® en la licuadora', :img_url => 'tutorial-licuar.jpg', :video_url => 'tutorial-licuar.mov'}
          when 'mezclar'
            f = 't_mezclar'
          when 'hornear'
            f = 't_hornear'
          when 'batir'
            f = 't_batir'
        end
        r = r.portutorial(f) if f
        @video_tutorial = video_tutorial unless video_tutorial.blank?

      when /(^platillo-)/
        p = params[:filtro].sub(/^platillo-(.*)/){ $1 }
        case p
          when 'desayuno'
            f = 'desayuno'
          when 'sopa'
            f = 'p_sopa'
          when 'entrada'
            f = 'p_entrada'
          when 'carne'
            f = 'p_carne'
          when 'cerdo'
            f = 'p_cerdo'
          when 'postre'
            f = 'p_postre'
          when 'botana'
            f = 'p_botana'
          when 'pollo'
            f = 'p_aves'
          when 'pescado'
            f = 'p_pescado'
          when 'pasta'
            f = 'p_pasta'
          when 'ensalada'
            f = 'p_ensalada'
        end

        r = r.porplatillo(f) if f
    end

    case params[:tiempo].to_i
      when 1
        r = r.portiempo(0..20)
      when 2
        r = r.portiempo(21..40)
      when 3
        r = r.portiempo(41..60)
      when 4
        r = r.portiempo(60..1000)
    end

    @recetas = r.publicado

    @porgrupo = Grupo.all
  end
  def show
    @receta = Recipe.show(params[:id])
    if params[:slug].blank? || params[:slug] != @receta.slug
      return redirect_to receta_path(@receta.id, @receta.slug), status: 301
    end
    @utensilios = @receta.utensilios

    render :show_comunidad unless @receta.usos.map{|u| u.id }.include?(1)

    rescue ActiveRecord::RecordNotFound
      render file: "#{Rails.root}/public/recetas_404.html", status: 404, layout: true
  end

  def mail
    IngredientesMailer.ingredientes(params[:email], params[:recipe_id]).deliver unless
      [params[:email], params[:recipe_id]].map(&:blank?).any?
    redirect_to receta_path(params[:recipe_id]), notice: "Revisa tu correo para encontrar la receta"
  end

  def busqueda
    r = Recipe.busqueda(params[:q] || "").order("recetas.tiempo, recetas.id").page(params[:page]).per(24)
    @porgrupo = Grupo.all
    @recetas = r.publicado((:comunidad if params[:tipo] == 'comunidad'))
    render (if params[:tipo] == 'comunidad' then :comunidad else :index end)
  end
  
  def busquedaapp
    r = Recipe.busqueda(params[:q] || "").order("recetas.tiempo, recetas.id").page(params[:page]).per(24)
    @porgrupo = Grupo.all
    @recetas = r.publicado((:comunidad if params[:tipo] == 'comunidad'))
    #render (if params[:tipo] == 'comunidad' then :comunidad else :index end)
    render json: @recetas
  end

  def comunidad
    @recetas = Recipe.publicado(:comunidad).order("recetas.orden, recetas.tiempo, recetas.id").page(params[:page]).per(24)
  end

  def feed
    @recetas = Recipe.publicado.order('recetas.id DESC').limit(20)

    respond_to do |format|
      format.rss{ render :layout => false }
    end
  end
end