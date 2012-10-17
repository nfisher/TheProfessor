require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, :test)
require File.join(File.dirname(__FILE__), '..', 'lib', 'profile_app.rb')

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false
set :show_exceptions, false

def app
  ProfileApp
end

RSpec.configure do |config|
  config.include Rack::Test::Methods

  DataMapper.setup(:default, 'sqlite::memory:')
end

def flush_tables
  DataMapper.auto_migrate!
end

def username(firstname, lastname)
  # willing to assume that anyone using this in the test won't be retarded and supply a nil firstname or lastname
  firstname[0].downcase + lastname.downcase
end

def create_profile(firstname, lastname, uid)
  username ||= username(firstname, lastname)
  post '/api/profiles/', params = { :firstname => firstname, :lastname => lastname, :username => username, :uid => uid }
end

def create_article(title, subtitle, author, published, content)
  post '/api/articles', params = { :title => title, :subtitle => subtitle, :author => author, :published => published, :content => content}
end


def expected_json_profile(firstname, lastname, uid)
  username ||= username(firstname, lastname)
  "{\"id\":1,\"firstname\":\"#{firstname}\",\"lastname\":\"#{lastname}\",\"username\":\"#{username}\",\"uid\":#{uid},\"authorized_keys\":null}"
end

def expected_json_article(title, subtitle, author, date, content, id=1)
  "{\"id\":#{id},\"title\":\"#{title}\",\"subtitle\":\"#{subtitle}\",\"author\":\"#{author}\",\"published\":\"#{date}\",\"content\":\"#{content}\"}"
end

def status_should(status)
  last_response.status.should status
end

def headers(header_name)
  last_response.headers[header_name]
end

