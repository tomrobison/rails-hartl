source 'https://rubygems.org'
ruby '2.1.2'
#ruby-gemset=railstutorial_rails_4_0

gem 'unicorn'

gem 'rails', '4.0.2'
gem 'bootstrap-sass', '2.3.2.0'
gem 'bcrypt-ruby', '3.1.2'
gem 'faker', '1.1.2'
gem 'will_paginate', '3.0.4'
gem 'bootstrap-will_paginate', '0.0.9'
gem 'sass-rails', '4.0.1'
gem 'uglifier', '2.1.1'
gem 'coffee-rails', '4.0.1'
gem 'jquery-rails', '3.0.4'
gem 'turbolinks', '1.1.1'
gem 'jbuilder', '1.0.2'

group :development, :test do
  gem 'sqlite3', '1.3.8'
  gem 'rspec-rails', '2.13.1'
  gem 'guard-rspec', '2.5.0'

  # Spork
  gem 'childprocess', '0.3.6'
  gem 'guard-spork', '1.5.0'
  gem 'spork-rails', '4.0.0'
end

group :test do
  gem 'factory_girl_rails', '4.2.1'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner'

  gem 'cucumber-rails', '1.4.0', :require => false
  gem 'selenium-webdriver', '2.35.1'
  gem 'capybara', '2.1.0'

  # Guard Notifier for OS X.
  # gem 'growl', '1.0.3'

  # Guard Notifier for Linux.
  gem 'libnotify', '0.8.0'

  # Guard Notifier for Windows.
  # gem 'rb-notifu', '0.0.4'
  # gem 'win32console', '1.3.2'
  # gem 'wdm', '0.1.0'
end

group :doc do
  gem 'sdoc', '0.3.20', require: false
end

group :production do
  gem 'pg', '0.15.1'
  gem 'rails_12factor', '0.0.2'
  gem 'mysql'
end
