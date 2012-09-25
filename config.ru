require 'rubygems'
require 'bundler/setup'
Bundler.require
DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite::memory:')
require File.join(File.dirname(__FILE__), 'lib', 'app.rb')
DataMapper.finalize
DataMapper.auto_upgrade!

run App

