source 'http://rubygems.org'

gem 'rails', '3.2.0'


gem 'unicorn'
gem 'pg'
gem 'zurb-foundation'
gem 'bourbon'
gem 'haml'
gem 'asset_sync'
gem 'paperclip', '~> 2.7'
gem 'aws-sdk', '~> 1.3.4'
gem 'sass-rails',   '~> 3.0'
gem 'jquery-rails'
gem 'activeadmin', git: 'https://github.com/gregbell/active_admin.git'
gem 'meta_search',    '~> 1.1.2'
gem 'friendly_id', '~> 4.0.0'
gem 'carrierwave'
gem 'fog'
gem 'hominid'
gem 'jquery_mobile_rails'

group :production do
  gem 'newrelic_rpm'
  gem 'dalli'
  gem 'hirefireapp'
end

group :development, :test do
  gem 'guard-livereload'
  gem 'foreman'
  gem 'haml-rails'
  gem 'therubyracer'
  # gem 'sqlite3'
  # gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
end

group :assets do
  gem 'coffee-rails', '~> 3.0'
  gem 'uglifier', '>= 1.0.3'
end
