class PagesController < ApplicationController
	layout 'pages'
  def index
  end

  def reto
  end
  
  def promocion
  @title = "soy promocion"
  end
  
  
  def chatyaz
  @title = "soy promocion"
  	respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def premios

   	respond_to do |format|
       format.html # index.html.erb
     end
   end
   
   def pre_index

  	respond_to do |format|
      format.html # index.html.erb
    end
  end
   
  def desafiountable
    @nombre=params[:nombre]
  	respond_to do |format|
      format.html # index.html.erb
    end
  end
   
  def promobases
		respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  
end
