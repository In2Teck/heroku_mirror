require 'rack-cache'

Creamcheese::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = false

  # Compress JavaScripts and CSS
  config.assets.compress = false 

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = true 

  # Generate digests for assets URLs
  config.assets.digest = true

  # Defaults to Rails.root.join("public/assets")
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  config.cache_store = :dalli_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  config.assets.precompile += %w( modernizr.js chat.js chat.css recetas.js receta.css receta_print.css active_admin.js active_admin.css mobile/mobile.css mobile/mobile.js )

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  config.action_mailer.default_url_options = { :host => 'philadelphia.com.mx' }

  # configurando cache
  config.middleware.use Rack::Cache,
    metastore: "memcached://#{ENV['MEMCACHE_SERVERS']}/meta",
    entitystore: "memcached://#{ENV['MEMCACHE_SERVERS']}/body"

  # estableciendo la vida del cache por 1 semana
  config.static_cache_control = 'public, max-age=604800'
  config.action_controller.asset_host = "http://philly2013.s3.amazonaws.com"

  PAPERCLIP_STORAGE_OPTIONS = {
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :bucket => "philly2013",
    :path => "/recetas/:attachment/:style/:filename"
 }
end
