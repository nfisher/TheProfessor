class App < Sinatra::Base
  NATHAN =<<-EOT
{"fullname": "Nathan Fisher", "profileNumber": "10101"}
  EOT

  TOM =<<-EOT
{"fullname": "Tom Cowling", "profileNumber": "10100"}
  EOT

  get '/' do
    "Hello"
  end

  get '/profiles/:profile' do
    profiles = { 10101 => NATHAN, 10100 => TOM }

    profile = params[:profile].to_i
    if profiles.has_key? profile
      profiles[profile]
    else
      halt 404, 'Not found.'
    end
  end
end

