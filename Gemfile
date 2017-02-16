source 'https://rubygems.org'

gem 'unicorn'

gem 'rails', '~> 4.0'
gem 'bootstrap-sass'
gem 'bcrypt-ruby'
gem 'faker'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder'

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'guard-rspec'

  # Spork
  gem 'childprocess'
  gem 'guard-spork'
  gem 'spork-rails'
end

group :test do
  gem 'factory_girl_rails'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner'

  gem 'cucumber-rails', :require => false
  gem 'selenium-webdriver'

  # Guard Notifier for OS X.
  gem 'growl'

  # Guard Notifier for Linux.
  # gem 'libnotify'

  # Guard Notifier for Windows.
  # gem 'rb-notifu'
  # gem 'win32console'
  # gem 'wdm'
end

group :doc do
  gem 'sdoc', require: false
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
