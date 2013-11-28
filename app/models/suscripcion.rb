# encoding: utf-8
class Suscripcion
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :nombre, :apellido, :email, :cp, :tos

  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i, :message => 'Tu email tiene que ser válido'
  validates :tos, :acceptance => { :value => true, :message => 'Tienes que aceptar términos y condiciones' }

  def initialize(attributes = {})  
    attributes.each do |name, value|  
      send("#{name}=", value)  
    end  
  end  

  def persisted?  
    false  
  end
end
