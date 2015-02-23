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

    it 'should have host' do
      expect(@maileon).to have_attributes(:host => a_string_starting_with("https"))
    end

    it 'should have path' do
      expect(@maileon).to have_attributes(:path => a_string_starting_with("/"))
    end

    it 'should have apikey' do
      expect(@maileon).to have_attributes(:apikey => Base64.encode64(ENV['MAILEON_APIKEY']).strip)
    end

    it 'should have debug' do
      expect(@maileon).to have_attributes(:debug => false)
    end

    it 'should have session' do
      expect(@maileon).to have_attributes(:session => be)
    end

  end

  describe "create contact" do

    before(:all) do
      @maileon = Maileon::API.new
    end

    it 'should fail without parameters' do
      expect { @maileon.create_contact() }.to raise_error(ArgumentError)
    end

    it 'should fail with empty parameters' do
      expect { @maileon.create_contact({}) }.to raise_error(ArgumentError, "No parameters.")
    end

    it 'should fail without email' do
      expect { @maileon.create_contact({:permission => 1}) }.to raise_error(ArgumentError, "Email is mandatory to create contact.")
    end

    it 'should throw validation error on invalid email' do
      params = {
        :email => 'dummy@email'
      }
      expect { @maileon.create_contact(params) }.to raise_error(Maileon::Errors::ValidationError, "Invalid email format.")
    end

    it 'should not throw validation error on valid email' do
      params = {
        :email => 'dummy@email.com'
      }
      expect { @maileon.create_contact(params) }.not_to raise_error
    end

  end


end