require File.join(File.dirname(__FILE__), 'models')

class App < Sinatra::Base
  get '/' do
    'Hello'
  end

  post '/profiles/' do
    if profile = Person.create(params)
      response.headers['Location'] = "http://#{request.host}/profiles/#{profile.id}"
      halt 201
    else
      halt 400, 'Not found.'
    end
  end

  get '/profiles/:profile' do
    if profile = Person.first(params[:profile])
      halt 200, profile.to_json
    else
      halt 404, 'Not found.'
    end
  end

  get '/profiles/' do
    profiles = Person.all
    halt 200, profiles.to_json
  end
end

