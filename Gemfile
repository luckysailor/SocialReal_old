source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Compress for twitter-bootstrap assets
gem 'less-rails'

gem 'therubyracer', platforms: :ruby, require: 'v8'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

gem 'font-awesome-rails'

# Twitter-bootstrap
gem 'less-rails-bootstrap'

gem 'devise'

gem 'cancan'

gem 'carrierwave'

# Bitmask to cancan
gem 'role_model'

group :production do
	gem 'rmagick'
end

group :development do
 gem 'capistrano'
 gem 'mailcatcher'
end

group :test do
	gem 'minitest-spec-rails'
	gem 'capybara'
	gem 'selenium-webdriver'
end

group :test, :development do
	gem 'sqlite3'
# gem 'debugger'
  gem 'spring'
end