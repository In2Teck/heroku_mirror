class Product < ActiveRecord::Base
  attr_accessible :titulo, :descripcion
  has_many :recipes

  extend FriendlyId
  friendly_id :titulo, use: :slugged

  def to_s
    titulo
  end
end
