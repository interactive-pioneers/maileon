require 'spec_helper'
require 'dotenv'
require 'excon'

describe Maileon::API do

  describe "initilisation" do

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

  describe "attributes" do

    before(:all) do
      Dotenv.load
      @maileon = Maileon::API.new
    end

    it 'host' do
      expect(@maileon).to have_attributes(:host => a_string_starting_with("https"))
    end

    it 'path' do
      expect(@maileon).to have_attributes(:path => a_string_starting_with("/"))
    end

    it 'apikey' do
      expect(@maileon).to have_attributes(:apikey => Base64.encode64(ENV['MAILEON_APIKEY']).strip)
    end

    it 'debug' do
      expect(@maileon).to have_attributes(:debug => false)
    end

    it 'session' do
      expect(@maileon).to have_attributes(:session => be)
    end

  end


end