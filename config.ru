require 'bundler'
Bundler.setup :default, (ENV['RACK_ENV'] || 'development')

require 'sprockets'
require 'compass'
require 'sprockets-sass'
require 'coffee-script'

map '/assets/' do
  environment = Sprockets::Environment.new
  environment.append_path 'vendor/assets/javascripts'
  environment.append_path 'vendor/assets/stylesheets'
  environment.append_path 'vendor/assets/images'
  environment.append_path 'app/assets/javascripts'
  environment.append_path 'app/assets/stylesheets'
  environment.append_path 'app/assets/images'
  environment.append_path 'app/assets/html'

  environment.register_engine '.haml', Tilt::HamlTemplate

  run environment
end

map '/' do
  run Rack::Directory.new("public")
end
