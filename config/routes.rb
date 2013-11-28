# http://stackoverflow.com/questions/4207657/rails-routing-to-handle-multiple-domains-on-single-application
class FormatConstraint
  def initialize
  end
 
  def matches?(request)
    request.user_agent =~ /Mobile|webOS/ && (request.user_agent =~ /ipad/i).nil? ? true : false
  end
end

Creamcheese::Application.routes.draw do
  if Rails.env.production?
    # http://stackoverflow.com/questions/4372896/rails-ensuring-www-is-in-the-url
    redirect_proc = Proc.new { 
      redirect do |params, request|
        URI.parse(request.url).tap { |x| x.host = "www.philadelphia.com.mx" }.to_s
      end
    }
    constraints(host: "philadelphia.com.mx") do
      match "(*x)" => redirect_proc.call
    end
    constraints(host: "creamcheese.herokuapp.com") do
      match "(*x)" => redirect_proc.call
    end
  end
  
  match 'academia' => redirect('http://www.academiaphiladelphia.com.mx/cocina-elaborada')
  match 'consentidas' => redirect('http://www.consentidas.com.mx/')
  
  
  

  constraints FormatConstraint.new do
    root :to => 'mobile#index'
    get 'index' => "mobile#index"
    get 'premios' => "mobile#premios"
    get 'recetas' => 'mobile#index'
    get 'recetas/buscar' => "mobile#buscar"
    get 'recetas/:categoria' => "mobile#recetas", as: 'mobile_recetas'
    get 'recetas/recetaslista' => "mobile#recetaslista", as: 'recetaslista'
    get 'catmobile' => "mobile#catmobile", as: 'catmobile'
    
  end

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root to: 'index#index'

  get 'festejemos' => 'index#festejemos'
  get 'reto' => 'index#reto'
  get 'recomendada' => 'index#recomendada'

  resources :pages
   match 'chatyaz' => 'pages#chatyaz'
   match 'premios' => 'pages#premios'
   match 'promobases'  => 'pages#promobases'
   
   
  get 'boletin' => 'chimp#index'
  post 'boletin' => 'chimp#suscripcion'

  match 'salud/imc' => 'salud#imc'
  match 'salud/calorias' => 'salud#calorias'
  match 'salud/peso' => 'salud#peso'

  match 'recetas' => 'receta#index'
  match 'recetas/index' => redirect('/recetas')
  match 'recetas/service'  => 'receta#service'
  match 'producto' => redirect('/#producto')
  match 'noticias' => redirect('/')
  match 'index.php' => redirect('/')
  match 'receta/:id(/:slug.html)' => 'receta#show', as: 'receta', constraints: { id: /\d{1,3}/ }
  match 'receta/busqueda' => 'receta#busqueda'
  match 'receta/busquedaapp' => 'receta#busquedaapp'
  match 'recetas(/:tipo)/busqueda' => 'receta#busqueda'
  match 'recetas/feed' => 'receta#feed'
  match 'recetas/comunidad' => 'receta#comunidad'
  match 'recetas(/:categoria)' => redirect('/recetas')
  # match 'receta_mail/:id' => 'receta#mail', as: 'receta_mail'

  match 'marca/politicas' => 'marca#politicas'
  match 'marca/ayuda' => 'marca#ayuda'
  match 'marca/legal' => 'marca#legal'
  match 'marca/contacto' => 'marca#contacto'
  match 'marca/promocion' => 'marca#promocion'
  
  match "chat" => 'chat#index'
  get "chat/call"

  match 'recompensas' => redirect('http://recompensasphiladelphia.com')

  # redirecciona la direccion que aparece en un QR a un video
  match 'yazmin' => redirect('/recetas')
  match 'qr/:qr' => 'index#qr'

  #ultima ruta siempre plx
  match '*a' => 'errors#routing'
end
