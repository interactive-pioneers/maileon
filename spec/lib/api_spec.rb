require 'spec_helper'
require 'dotenv'
require 'excon'

describe Maileon::API do

  describe '.initialize' do
    context 'without API key' do
      it { expect { Maileon::API.new }.to raise_error }
    end
    context 'with API key' do
      it { expect(Maileon::API.new('2iaodsfi4u83943uruqf')).to be_an_instance_of Maileon::API }
    end
    context 'with environment-based API key' do
      it {
        ENV['MAILEON_APIKEY'] = 'adsfadsi4292r0vajsfdafldkaf'
        is_expected.to be_an_instance_of Maileon::API
      }
    end
  end

  describe Maileon::API.new('asdfasdfasdfa') do
    context 'when initiliased' do
      it { is_expected.to have_attributes(:host => a_string_starting_with("https://")) }
      it { is_expected.to have_attributes(:path => a_string_starting_with("/")) }
      it { is_expected.to have_attributes(:apikey => Base64.encode64('asdfasdfasdfa').strip) }
      it { is_expected.to have_attributes(:debug => false) }
      it { is_expected.to have_attributes(:session => be) }
    end
  end

  describe 'ping' do
    before(:all) do
      skip "Not implemented"
      @maileon = Maileon::API.new
    end
    it 'should respond with 200' do
      # TODO implement
    end
  end

  describe 'subscription' do
    before(:all) do
      @maileon = Maileon::API.new
    end
    context 'without parameters' do
      it { expect { @maileon.create_contact() }.to raise_error(ArgumentError) }
    end
    context 'with empty parameters' do
      it { expect { @maileon.create_contact({}) }.to raise_error(ArgumentError, "No parameters.") }
    end
    context 'without email' do
      it { expect { @maileon.create_contact({:permission => 1}) }.to raise_error(ArgumentError, "Email is mandatory to create contact.") }
    end
    context 'with invalid email' do
      it { expect { @maileon.create_contact({ :email => 'dummy@email' }) }.to raise_error(Maileon::Errors::ValidationError, "Invalid email format.") }
    end
    context 'with valid email' do
     it { expect { @maileon.create_contact({ :email => 'dummy@email.com' }) }.not_to raise_error }
    end
  end
end