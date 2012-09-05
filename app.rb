require 'rubygems'
require 'bundler/setup'
Bundler.require

class App < Sinatra::Base
  get '/' do
    "No, I am not!"
  end
end
