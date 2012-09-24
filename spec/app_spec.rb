require 'spec_helper'

describe 'App' do
  it 'should respond to GET' do
    get '/'
    last_response.should be_ok
    last_response.body.should match(/Hello/)
  end

  # TODO: This is a shitty test name
  it 'should return a profile when found' do
    get '/profiles/10101'
    last_response.should be_ok
    expected =<<-EOT
{"fullname": "Nathan Fisher", "profileNumber": "10101"}
    EOT
    last_response.body.should eq(expected)
  end

  # TODO: This is a shitty test name
  it 'should return an alternate profile when found' do
    get '/profiles/10100'
    last_response.should be_ok
    expected =<<-EOT
{"fullname": "Tom Cowling", "profileNumber": "10100"}
    EOT
    last_response.body.should eq(expected)
  end

  it 'should return an error when a profile is not found' do
    get '/profiles/20000'
    last_response.should_not be_ok
    last_response.status.should be(404)
  end
end
