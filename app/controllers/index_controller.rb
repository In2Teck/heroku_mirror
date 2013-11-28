# encoding: utf-8
class IndexController < ApplicationController
  def index
  end

  def festejemos
  end
  
  def reto
  end

  def qr
    render :text => "QR ##{params[:qr]} aquí"
  end
  
  def recomendada
  	
  end
  
  
  
end
