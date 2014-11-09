source 'https://rubygems.org'

#= CORE =================================
gem 'rails', '4.1.7'

#= DATABASE =============================
gem 'pg'

#= ASSETS ===============================
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'compass-rails'
gem 'bootstrap-sass'

#= ACTIVE RECORD =======================
gem 'devise', '~> 3.4.1'
gem 'acts_as_list', '~> 0.5.0'

#= VIEWS ===============================
gem 'will_paginate', '~> 3.0.7'
gem 'will_paginate-bootstrap', '~> 1.0.1'
gem 'slim', '~> 2.0.3'
gem 'htmlentities', '~> 4.3.2'
gem "font-awesome-rails"

#= AUTHENTICATION =================

#= UPLOADS ========================
gem 'paperclip', '~> 4.2.0'


#= PRODUCTION =====================
group :production, :staging do
  gem 'exception_notification', '~> 4.0.1'
end

#= DEV ============================
group :development do
  gem "capistrano"
  gem "rvm-capistrano"
end

group :development, :test do
  gem 'did_you_mean'
end
