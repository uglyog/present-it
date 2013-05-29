require 'bundler'
Bundler.setup :default, (ENV['RACK_ENV'] || 'development')

require 'sprockets'
require 'compass'
require 'sprockets-sass'
require 'bootstrap-sass'
require 'coffee-script'

map '/' do
  environment = Sprockets::Environment.new
  environment.append_path 'app/assets/javascripts'
  environment.append_path 'app/assets/stylesheets'
  environment.append_path 'app/assets/images'
  environment.append_path 'app/assets/html'

  # Adds Twitter Bootstrap Javascripts
  environment.append_path Compass::Frameworks['bootstrap'].templates_directory + '/../vendor/assets/javascripts'

  environment.register_engine '.haml', Tilt::HamlTemplate

  run environment
end
