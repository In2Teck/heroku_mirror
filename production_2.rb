require 'rack-cache'

Creamcheese::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

ENV['ANALYTICS_KEY'] = "UA-18523507-14"
ENV['ANALYTICS_KEY2']="UA-18523507-14"
ENV['DATABASE_URL']="postgres://uf2egck26pub0h:pagstqfj00j7qjqnjjpjs77n34@ec2-54-225-230-213.compute-1.amazonaws.com:6652/del50iv2jpi99d"
ENV['ERROR_PAGE_URL']="http://philly.2013.s3.amazonaws.com/error/error500.html"
ENV['FB_API']="388687384533289"
ENV['FB_APP_ID']="155409044482204"
ENV['FB_SECRET']="1265a78c39b1b433fba6fd6b1e0fdab2"
ENV['FOG_DIRECTORY']="philly2013"
ENV['GEM_PATH']="vendor/bundle/ruby/1.9.1"
ENV['HEROKU_POSTGRESQL_BRONZE_URL']="postgres://uf2egck26pub0h:pagstqfj00j7qjqnjjpjs77n34@ec2-54-225-230-213.compute-1.amazonaws.com:6652/del50iv2jpi99d"
ENV['HEROKU_POSTGRESQL_NAVY_URL']="postgres://ikvwbovtpdpipp:Uw7Ls5i2mgVixd9JX19EiP05-7@ec2-23-21-209-52.compute-1.amazonaws.com:5432/dcjchhuiil8d94"
ENV['HIREFIREAPP_TOKEN']="6156efc7ae828d0a5cb5193b322c14416482cafd"
ENV['LANG']="en_US.UTF-8"
ENV['MAINTENANCE_PAGE_URL']="http://phillybeta.herokuapp.com/"
ENV['MEMCACHIER_PASSWORD']="293213cc84"
ENV['MEMCACHIER_SERVERS']="mc4.dev.ec2.memcachier.com:11211"
ENV['MEMCACHIER_USERNAME']="5f15ae"
ENV['NEW_RELIC_APP_NAME']="creamcheese"
ENV['NEW_RELIC_ID']="78421"
ENV['NEW_RELIC_LICENSE_KEY']="23c242c7edea1550794d9a0f15cdeacdf880e0dc"
ENV['NEW_RELIC_LOG']="stdout"
ENV['PATH']="bin:vendor/bundle/ruby/1.9.1/bin:/usr/local/bin:/usr/bin:/bin"
ENV['PGBACKUPS_URL']="https://14027:8asqu9n9gacpe14axbglpv49x@pgbackups.heroku.com/client"
ENV['RACK_ENV']="production"
ENV['RAILS_ENV']="production"
ENV['S3_BUCKET_NAME']="philly2013"
ENV['S3_KEY']="AKIAISCA64FNWOMLG32Q"
ENV['S3_SECRET']="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"
ENV['SENDGRID_PASSWORD']="oob2k12send"
ENV['SENDGRID_USERNAME']="outofthebox"
ENV['TW_API']="q0M1B6FcIYSFzKzoO1RLTA"
ENV['TW_SECRET']="8EPXBebXqfxJRAvVLkJXL2VDmt3mOu8lTfRXhm8E"

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = false

  # Compress JavaScripts and CSS
  config.assets.compress = true

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
  #config.cache_store = :dalli_store

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
