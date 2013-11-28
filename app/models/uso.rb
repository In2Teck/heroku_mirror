class Uso < ActiveRecord::Base
  has_and_belongs_to_many :recipes

  def to_s
    nombre
  end
end
