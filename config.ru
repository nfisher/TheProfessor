require 'rubygems'
require 'bundler/setup'
Bundler.require
require File.join(File.dirname(__FILE__), 'lib', 'app.rb')

run App

