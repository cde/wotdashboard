# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
#Heroku has a read-only filesystem, so uploads must be stored on S3 and cannot be cached in the public directory.
#Until we set S3 we're gonna set cache_dir' See initializer/carrierwave.rb
#use Rack::Static, :urls => ['/uploads'], :root => 'tmp'
run Wotdashboard::Application
