source :rubygems
ruby '1.9.3'

gem 'sinatra', '1.3.3', :require => 'sinatra'
gem 'data_mapper', '1.2.0', :require => ['data_mapper', 'dm-serializer/to_json']

group :development do
  gem 'heroku'
  gem 'shotgun'
  gem 'dm-sqlite-adapter', :require => 'dm-sqlite-adapter'
end

group :production do
  gem 'pg'
  gem 'dm-postgres-adapter', :require => 'dm-postgres-adapter'
  gem 'puma'
end

group :test do
  gem 'autotest'
  gem 'rspec'
  gem 'rack-test', :require => 'rack/test'
  gem 'autotest-fsevent'
  gem 'autotest-growl'
end
