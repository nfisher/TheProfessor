require File.join(File.dirname(__FILE__), 'models')

class ProfileApp < Sinatra::Base
  set :views, File.join(File.dirname(__FILE__), 'views')
  set :haml, :layout => :layout, :format => :html5

  get '/' do
    'Hello'
  end

  #
  # UI
  #
  get '/profiles/new' do
    haml :'profiles/new', :format => :html5
  end


  #
  # API
  #
  post '/api/profiles/?' do
    profile = Person.create(params)
    if profile.saved? 
      response.headers['Location'] = "http://#{request.host}/api/profiles/#{profile.id}"
      halt 201, profile.to_json
    else
      halt 400, profile.errors.to_hash.to_json
    end
  end

  get '/api/profiles/:profile' do
    if profile = Person.first(params[:profile])
      response.headers['Content-Type'] = 'application/json'
      halt 200, profile.to_json
    else
      halt 404, 'Not found.'
    end
  end

  get '/api/profiles/?' do
    profiles = Person.all
    response.headers['Content-Type'] = 'application/json'
    halt 200, profiles.to_json
  end
end

