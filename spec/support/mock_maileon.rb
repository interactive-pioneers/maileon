require 'sinatra/base'

class MockMaileon < Sinatra::Base

  API_KEY = 'adsfadsi4292r0vajsfdafldkaf'

  post '/1.0/contacts' do
    json_response is_valid_api_key? ? 200 : 401, 'create_contact.json'
  end

  get '/1.0/ping' do
    json_response is_valid_api_key? ? 200 : 401, 'ping.json'
  end

  private

  def is_valid_api_key?
    key = request.env['HTTP_AUTHORIZATION'].split(' ').last
    Base64.encode64(API_KEY).strip == key
  end

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
  end
end