require 'coveralls'

# Code coverage
Coveralls.wear!

require 'pry'
require 'maileon'
require 'webmock/rspec'
require 'support/mock_maileon'
require 'rspec/its'

# Do not allow external calls to API
WebMock.disable_net_connect!(allow_localhost: true)

# Stub all external API calls for WebMock
RSpec.configure do |config|
  config.before(:each) do
    stub_request(:any, /api.maileon.com/).to_rack(MockMaileon)
  end
end
