class Recipe < ActiveRecord::Base
  self.table_name = 'recetas'

  extend FriendlyId
  friendly_id :titulo, use: :slugged

  scope :no_modificado, where(migrado: false)
  scope :modificado, where(migrado: true)
  scope :sin_foto, where(recipe_photo: nil)
  scope :con_foto, where('recipe_photo IS NOT NULL OR pic_big_file_name IS NOT NULL')

  scope :porgrupo, lambda{|slug| joins(:grupos).where("grupos.slug = ?", slug) }
  scope :porplatillo, lambda{|fields| where (fields.kind_of?(Array) ? fields : fields.split ).map{|f| "recetas.#{f} = true" }.join(" OR ") }
  scope :portutorial, lambda{|field| where("recetas.#{field} = true") }

  before_save :mark_as_migrated

  attr_accessible :titulo, :slug, :product_id, :tiempo, :porciones, :dificultad, :grupo_ids,
    :desayuno, :p_postre, :p_sopa, :p_botana, :p_entrada, :p_aves, :p_carne, :p_ensalda,
    :p_pescado, :p_cerdo, :p_pasta, :ingredientes, :preparacion, :tips, :etiquetas,
    :t_relleno, :t_licuadora, :t_sarten, :t_mezclar, :t_hornear, :t_batir,
    :utensilio_ids, :recipe_photo, :pic_small, :pic_big, :uso_ids, :medio_ids, :orden,
    :video, :video_url, :comunidad_autor, :p_chocolate

  validates_presence_of :titulo, :product, :tiempo, :porciones,
    :ingredientes, :preparacion

  # disabling so the slugs can be generated
  # validates_presence_of :utensilios
  # validate :tipo_platillo_present?

  belongs_to :product
  has_and_belongs_to_many :utensilios
  has_and_belongs_to_many :grupos
  has_and_belongs_to_many :usos, :join_table => "receta_usos", :foreign_key => "receta_id"
  has_and_belongs_to_many :medios, :join_table => "receta_medios", :foreign_key => "receta_id"
  has_attached_file :pic_big, {
      :styles => { :normal => "680x460#", :mini => "136x92#" }
    }.merge(PAPERCLIP_STORAGE_OPTIONS)
  has_attached_file :pic_small, {
      :styles => { :normal => "200x200#", :mini => "55x55#" }
    }.merge(PAPERCLIP_STORAGE_OPTIONS)

  mount_uploader :recipe_photo, RecipePhotoUploader

  def self.show(id)
    self.publicado(:todo).find(id)
  end

  def self.publicado(q=:recetas)
    filtros = {
      :recetas => [1],
      :comunidad => [8],
      :todo => [1, 8]
    }
    q = :recetas unless filtros.keys.include?(q)

    self.includes(:usos).where("usos.id IN (#{filtros[q].join(",")})")
  end

  def self.portiempo(range)
    where(tiempo: range)
  end

  def to_s
    titulo
  end

  def videoreceta?
    video
  end

  def featured?
    featured
  end

  def new?
    self.created_at > Date.today-15.days unless self.created_at.nil?
  end

  def self.has_new?
    self.publicado.where('recetas.created_at > ?', Date.today-15.days).size >= 1 ? true : false
  end

  def tipos_platillo
    tipos = []
    tipos << "Plato Fuerte" if p_platofuerte && (!p_aves && !p_carne && !p_pasta && !p_pescado && !p_otros && !p_cerdo)
    tipos << "Plato Fuerte - Aves" if p_aves
    tipos << "Plato Fuerte - Carne" if p_carne
    tipos << "Plato Fuerte - Pasta" if p_pasta
    tipos << "Plato Fuerte - Pescado" if p_pescado
    tipos << "Plato Fuerte - Otros" if p_otros
    tipos << "Entradas" if p_entrada
    tipos << "Botanas" if p_botana
    tipos << "Ensaladas" if p_ensalada
    tipos << "Guarniciones" if p_guarnicion
    tipos << "Sopas" if p_sopa
    tipos << "Recetas Light" if p_light
    tipos << "Postres" if p_postre
    tipos << "Ensalada" if p_ensalada
    tipos << "Desayuno" if desayuno
    tipos
  end

  def tipo_tutorial
    tutoriales = []
    tutoriales << "licuar" if t_licuadora
    tutoriales << "hornear" if t_hornear
    tutoriales << "rellenar" if t_relleno
    tutoriales << "calentar" if t_sarten
    tutoriales << "mezclar" if t_mezclar
    tutoriales << "batir" if t_batir
    tutoriales
  end

  def plato_fuerte?
    p_aves || p_carne || p_pasta || p_pescado || p_otros || p_cerdo
  end

  def tipo_platillo_present?
    if %w(desayuno p_postre p_sopa p_botana p_entrada p_aves p_carne p_pescado p_cerdo p_pasta).all? {|attr| self[attr].blank?}
      errors[:base] << "Selecciona al menos un tipo de platillo"
    end
  end

  def small_photo
    if recipe_photo.blank?
      "http://phillybeta.outofthebox.mx/recetas/clasico/#{imagen}.jpg"
    else
      recipe_photo.to_s.gsub /uploads/, 'thumbnails200'
    end
  end
  
  def self.busqueda(q)
    query = []
    q.parameterize.split("-").each do |q|
      query << "to_tsvector(etiquetas) @@ to_tsquery('#{sprintf('%s', q)}')"
    end
    self.where query.join(' OR ')
  end
  
  private
  def mark_as_migrated
    return if self.new_record?
    
    update_column(:migrado, true) unless utensilios.blank?
  end

end
