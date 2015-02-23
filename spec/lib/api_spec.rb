require 'spec_helper'
require 'dotenv'

describe Maileon::API do

  it 'should throw error without API key' do
    expect { Maileon::API.new }.to raise_error
  end

  it 'should initilize with API key' do
    expect(Maileon::API.new('2iaodsfi4u83943uruqf')).to be_an_instance_of Maileon::API
  end

  it 'should have API environment variable set' do
    Dotenv.load
    expect(ENV['MAILEON_APIKEY']).to be_a(String)
  end

  it 'should initilize with API key from environment' do
    Dotenv.load
    expect(Maileon::API.new).to be_an_instance_of Maileon::API
  end

end