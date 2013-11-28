class ApplicationController < ActionController::Base
  protect_from_forgery
  require 'active_admin_views_pages_base.rb'


  before_filter do
    @recetas_nuevas = Recipe.has_new? 
  end
  before_filter :prepare_for_mobile

  def mobile_device?
    request.user_agent =~ /Mobile|webOS/ && (request.user_agent =~ /ipad/i).nil? ? true : false
  end

  def prepare_for_mobile
    request.format = :mobile if mobile_device? || !(ENV['IS_MOBILE'] || "").empty?
  end

  before_filter do
    @recetas_nuevas = Recipe.has_new?
  end
end
