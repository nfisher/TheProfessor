require File.join(File.dirname(__FILE__), 'models')

class ProfileApp < Sinatra::Base
  set :views, File.join(File.dirname(__FILE__), 'views')
  set :haml, :layout => :layout, :format => :html5, :ugly => true

  get '/' do
    'Hello'
  end

  #
  # UI
  #
  get '/profiles/new' do
    haml :'profiles/new', :format => :html5
  end

  get '/profiles/:profile_id/edit' do
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

  # article
  #
  get '/api/articles/:id.json' do
    article = Article.get(params[:id])
    article.to_json
  end

  post '/api/articles/?' do
    article = Article.create(params)
    if article.saved? 
      response.headers['Location'] = "http://#{request.host}/api/articles/#{article.id}"
      halt 201, article.to_json
    else
      halt 400, article.errors.to_hash.to_json
    end
  end

  get '/articles/?' do
    @articles = Article.all()
    haml :'articles/index'
  end

  get '/articles/new' do
    haml :'articles/new'
  end
end

