# loads dependencies and provides helpers like expected_json_profile, status_should, etc
require 'spec_helper'

describe 'ProfileApp' do
  before :each do
    flush_tables
  end

  it 'should respond to a GET request' do
    get '/'
    last_response.should be_ok
    last_response.body.should match(/Hello/)
  end

  it 'should return a form' do
    get '/profiles/new'
    last_response.should be_ok
  end

  it 'should return an edit form' do
    create_profile('Bamdad', 'Dashtban', 1238)
    get '/profiles/1/edit'
    last_response.should be_ok
  end

  describe "profile api" do
    it 'should return an error when a profile is not found' do
      get '/api/profiles/40404'
      last_response.should_not be_ok
      status_should be(404)
    end

    it 'should return a profile when found' do
      create_profile('Bamdad', 'Dashtban', 1238)
      get '/api/profiles/1'
      last_response.should be_ok
      headers('Content-Type').should eq('application/json')
      last_response.body.should eq(expected_json_profile('Bamdad', 'Dashtban', 1238))
    end

    it 'should create a profile when all details are POSTed' do
      create_profile('Andy', 'Robinson', 1234)
      status_should be(201)
      headers('Location').should eq('http://example.org/api/profiles/1')
    end

    it 'should not create a profile when uid is missing' do
      create_profile('Nathan', 'Fisher', nil)
      status_should be(400)
      last_response.body.should include('uid')
    end

    it 'should have a unique Location for each newly created profile' do
      create_profile('Ignacio', 'Duarte', 1235)
      status_should be(201)
      andys_location = headers('Location')

      create_profile('Tom', 'Cowling', 1236)
      status_should be(201)
      nathans_location = headers('Location')

      nathans_location.should_not eq(andys_location)
    end

    it 'should provide an empty list if no profiles exist' do
      get '/api/profiles/'
      last_response.should be_ok
      last_response.body.should eq('[]')
      headers('Content-Type').should eq('application/json')
    end

    it 'should provide the url, firstname and lastname for each profile.' do
      create_profile('Nathan', 'Fisher', 1239)
      get '/api/profiles/'
      last_response.should be_ok
      headers('Content-Type').should eq('application/json')
      # TODO: should include the self-referencing URL for the profile
      last_response.body.should eq("[#{expected_json_profile('Nathan', 'Fisher', 1239)}]")
    end
  end
end
