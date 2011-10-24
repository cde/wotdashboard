source 'http://rubygems.org'

gem 'rails', '3.1.0'

gem "devise", ">= 1.4.5"
gem "frontend-helpers"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

# Use unicorn as the web server
# gem 'unicorn'

# To use debugger
gem 'ruby-debug19', :require => 'ruby-debug'

gem 'jquery-rails'
gem 'twitter-bootstrap-rails', '~> 0.0.5'

gem "haml", ">= 3.1.2"
gem "haml-rails", ">= 0.3.4", :group => :development
gem "rspec-rails", ">= 2.6.1", :group => [:development, :test]
gem "pry"
gem "csv-mapper"
gem 'carrierwave'

group :test do
	gem "factory_girl_rails", ">= 1.2.0"
	gem "cucumber-rails", ">= 1.0.2"
	gem "capybara", ">= 1.1.1"
	gem "database_cleaner", ">= 0.6.7"
	gem "launchy", ">= 2.0.5"
  gem "shoulda"
end
group :development do
	gem "guard", ">= 0.6.2"
	gem "guard-bundler", ">= 0.1.3"
	gem "guard-rails", ">= 0.0.3"
	gem "guard-livereload", ">= 0.3.0"
	gem "guard-rspec", ">= 0.4.3"
	gem "guard-cucumber", ">= 0.6.1"
	gem "rails-footnotes", ">= 3.7"
end

group :development, :test do
  gem 'sqlite3'
end

group :production do
  gem 'pg'
end


