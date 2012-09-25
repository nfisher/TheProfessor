require 'spec_helper'

def create_profile(firstname, lastname, uid, username = nil)
  username ||= firstname[0].downcase +  lastname.downcase
  post '/profiles/', params = { :firstname => firstname, :lastname => lastname, :username => username, :uid => uid }
end

def status_should(status)
  last_response.status.should status
end

def location_header
  last_response.headers['Location']
end

describe 'App' do
  before :each do
    # This drops the table before each test ensuring it's clean.
    # The DB is a memory DB which means you could have many instances running in a commit build.
    DataMapper.auto_migrate!
  end

  it 'should respond to a GET request' do
    get '/'
    last_response.should be_ok
    last_response.body.should match(/Hello/)
  end

  it 'should return an error when a profile is not found' do
    get '/profiles/40404'
    last_response.should_not be_ok
    status_should be(404)
  end

  it 'should return a profile when found' do
    create_profile('Bamdad', 'Dashtban', 1238)
    get '/profiles/1'
    last_response.should be_ok
    last_response.body.should eq("{\"id\":1,\"firstname\":\"Bamdad\",\"lastname\":\"Dashtban\",\"username\":\"bdashtban\",\"uid\":1238}")
  end

  it 'should create a profile when details are POSTed' do
    create_profile('Andy', 'Robinson', 1234)
    status_should be(201)
    location_header.should eq('http://example.org/profiles/1')
  end

  it 'should have a unique Location for each newly created profile' do
    create_profile('Ignacio', 'Duarte', 1235)
    status_should be(201)
    andys_location = location_header

    create_profile('Tom', 'Cowling', 1236)
    status_should be(201)
    nathans_location = location_header

    nathans_location.should_not eq(andys_location)
  end

  it 'should provide an empty list if no profiles exist' do
    get '/profiles/'
    last_response.should be_ok
    last_response.body.should eq('[]')
  end

  it 'should provide the url, firstname and lastname for each profile.' do
    create_profile('Nathan', 'Fisher', 1239)
    get '/profiles/'
    last_response.should be_ok
    # TODO: should include the self-referencing URL for the profile
    last_response.body.should eq("[{\"id\":1,\"firstname\":\"Nathan\",\"lastname\":\"Fisher\",\"username\":\"nfisher\",\"uid\":1239}]")
  end
end
