class MarcaController < ApplicationController
  layout :detect_ajax

  def contacto
  end
  def ayuda
  end
  def politicas
  end
  def legal
  end
  def mapa
  end

  private
  def detect_ajax
    if params[:ajax]
      false
    else
      'static'
    end
  end
end
