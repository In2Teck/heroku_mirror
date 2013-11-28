class Grupo < ActiveRecord::Base
  has_and_belongs_to_many :recipes

  extend FriendlyId
  friendly_id :nombre, use: :slugged

  def recetas_s
    unless recips.blank?
      recipes.map(&:to_s).join(', ')
    else
      'Ninguna aun'
    end
  end

  def to_s
    nombre
  end
end
