class ChimpController < ApplicationController
  def index
    @suscripcion = Suscripcion.new
  end

  def suscripcion
    @suscripcion = Suscripcion.new params[:suscripcion]
    if @suscripcion.valid?
      h = Hominid::API.new('07098a0735b9cd716fa931604e6847d0-us6', {:secure => true, :timeout => 60})
      unless h.list_subscribe('bebb866068', params[:suscripcion][:email], {'FNAME' => params[:suscripcion][:nombre] || '', 'LNAME' => params[:suscripcion][:apellido] || '', 'CP' => params[:suscripcion][:codigo] || ''}, 'html', true, true, true, true).nil?
        flash[:notice] = "Gracias por suscribirte"
      end
      redirect_to "/boletin"
    else
      render :index
    end
  end
end

