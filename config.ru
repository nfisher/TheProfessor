require 'rubygems'
require 'bundler/setup'
Bundler.require

configure :development do
  DataMapper.setup(:default, 'sqlite::memory:')
end

configure :production do
  DataMapper.setup(:default, ENV['DATABASE_URL'])
end

require File.join(File.dirname(__FILE__), 'lib', 'profile_app.rb')
DataMapper.auto_upgrade!

run ProfileApp

