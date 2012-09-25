class Person
  include DataMapper::Resource
  property :id,   Serial
  property :firstname, String, :required => true
  property :lastname, String,  :required => true
  property :uid,  Integer,     :required => true
end

class App < Sinatra::Base
  get '/' do
    'Hello'
  end

  post '/profiles/' do
    if profile = Person.create(params)
      response.headers['Location'] = "http://#{request.host}/profiles/#{profile.id}"
      halt 201
    else
      halt 400
    end
  end

  get '/profiles/:profile' do
    if profile = Person.first(params[:profile])
      halt 200, profile.to_json
    else
      halt 404, 'Not found.'
    end
  end
end

