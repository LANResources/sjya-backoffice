source 'https://rubygems.org'
source 'https://2gzsjvsxbBG9UWWXiJQx@gem.fury.io/reed/'

ruby '2.0.0'

gem 'rails', '4.0.0'

# Database
gem 'pg'

# Webserver
gem 'thin', group: :development
gem 'unicorn', group: :production

# Asset Compilation
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

# Configuration
gem 'figaro'

# Authorization
gem 'pundit'

# Theme
gem 'lr-simpliq' #, git: 'https://github.com/LANResources/backoffice-theme.git', branch: 'simpliq-2.1.1'

# JavaScript
gem 'jquery-rails'
gem 'turbolinks'
gem 'dropzonejs-rails'
gem 'select2-rails'
gem 'best_in_place', git: 'https://github.com/bernat/best_in_place.git', branch: 'rails-4'

# JSON
gem 'jbuilder', '~> 1.2'

# Views
gem 'haml-rails'
gem 'will_paginate'
gem 'bootstrap-will_paginate'

# Files
gem "carrierwave"
gem "carrierwave-dropbox"
gem 'mini_magick'

# Mail
gem 'letter_opener', group: :development

# Surveys
gem 'rapidfire', git: 'https://github.com/LANResources/rapidfire.git', branch: 'master'

# Tagging
gem 'acts-as-taggable-on'

# Encryption
gem 'bcrypt-ruby', '~> 3.0.0'

# Debugging
gem 'exception_notification'
group :development do
  gem "pry"
  gem 'meta_request'
  gem 'rails-erd'
  gem 'hirb'
  gem 'awesome_print'
  gem 'methodfinder'
end

# Testing
group :development, :test do
  gem 'rspec-rails', '2.14.0'
  gem 'guard-rspec', '4.0.1'
  gem 'spork-rails', '4.0.0'
  gem 'guard-spork', '1.5.1'
  gem 'childprocess', '0.3.9'
  gem 'terminal-notifier-guard'
  gem 'debugger'
end

group :test do
  gem 'selenium-webdriver', '2.35.1'
  gem 'capybara', '2.1.0'
  gem 'factory_girl_rails', '4.2.1'
  gem 'cucumber-rails', '1.4.0', :require => false
  gem 'database_cleaner'
end

# Documentation
group :doc do
  gem 'sdoc', require: false
end
