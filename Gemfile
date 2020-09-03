source "https://rubygems.org"

ruby "2.3.1"


# Backend
gem "rails", "4.2.6"
gem 'pg'
gem "active_model_serializers", "0.9.3"
gem "slim-rails"
gem 'kaminari'
gem 'devise'
gem "ancestry"
gem 'acts_as_list'
gem 'acts-as-taggable-on', '~> 3.4'
gem 'traco'
gem 'redcarpet'
gem 'sitemap_generator'
gem 'whenever', :require => false
gem 'puma', '~> 3.12.6'
gem 'prawn'
gem 'pg_search'

# Assets
gem "font-awesome-rails"
gem "compass-rails"
gem "autoprefixer-rails"
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'therubyracer', platforms: :ruby
gem "bower-rails", "~> 0.9.2"

# Uploads and S3
gem 'mini_magick'
# gem 'fog'
# gem 'carrierwave'
gem 'dragonfly', '~> 1.0.7'
gem 'dragonfly-s3_data_store'

# Ember
gem 'ember-rails'
gem 'emblem-rails'
gem 'emblem-source', git:'https://github.com/machty/emblem.js.git', tag: '0.4.0'
gem "barber-emblem", github: "simcha/barber-emblem"
gem "ember-source", "1.9.1"
gem "ember-data-source", "1.0.0.beta.12"
gem "barbecue", github: "HakubJozak/barbecue", tag: 'v0.1'

# All Things Bootstrap
gem 'less-rails'
gem 'twitter-bootstrap-rails', github: 'seyhunak/twitter-bootstrap-rails', branch: 'bootstrap3'
gem 'simple_form'


# Redis
# gem "redis-store"
# gem 'redis-rails'
# gem "redis-rack-cache"

# FIX (je potreba kvuli rake taskum)
gem "dotenv-rails"


group :development do
  gem 'spring'
  gem 'faker'
end

group :test do
  gem 'minitest-reporters'
  gem 'mocha'
  gem "factory_girl_rails"
  gem "capybara"
  gem "poltergeist"
  gem 'database_cleaner'
end

group :development, :test do
  gem "byebug"
  gem "pry-rails"
end


group :staging, :production do
  gem 'dalli'
  gem 'rack-cache', require: 'rack/cache'
  gem 'foreman'
  gem "sentry-raven", :git => "https://github.com/getsentry/raven-ruby.git"
end



group :development do
  gem 'capistrano-sinfin', git: 'git@bitbucket.org:Sinfin/capistrano-sinfin.git', branch: 'master'
end
