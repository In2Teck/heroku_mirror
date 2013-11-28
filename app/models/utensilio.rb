class Utensilio < ActiveRecord::Base
  attr_accessible :nombre
  has_and_belongs_to_many :recipes

  extend FriendlyId
  friendly_id :nombre, use: :slugged
  
  def to_s
    nombre
  end
end
