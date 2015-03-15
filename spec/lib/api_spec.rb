require 'spec_helper'
require 'excon'
require 'support/mock_maileon'

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

  describe Maileon::API.new('asdfasdfasdfa', true) do
    context 'with debug flag' do
      it { is_expected.to have_attributes(:debug => true) }
    end
  end

  describe '.ping' do
    context 'with invalid API key' do
      it {
        @maileon = Maileon::API.new('9320293t90gaksdf5900434')
        expect(@maileon.ping.status).to eq 401
      }
    end
    context 'with valid API key' do
      it {
        @maileon = Maileon::API.new(MockMaileon::API_KEY)
        expect(@maileon.ping.status).to eq 200
      }
    end
  end

  describe '.create_contact' do
    before(:all) do
      @maileon = Maileon::API.new(MockMaileon::API_KEY)
    end
    context 'without parameters' do
      it { expect { @maileon.create_contact() }.to raise_error(ArgumentError) }
    end
    context 'with empty parameters' do
      it { expect { @maileon.create_contact({}) }.to raise_error(ArgumentError, "No parameters.") }
    end
    context 'without email' do
      it { expect { @maileon.create_contact({:permission => 1}) }.to raise_error(ArgumentError, "Email is mandatory.") }
    end
    context 'with invalid email' do
      it { expect { @maileon.create_contact({ :email => 'dummy@email' }) }.to raise_error(Maileon::Errors::ValidationError, "Invalid email format.") }
      it { expect { @maileon.create_contact({ :email => 'dummy@email.2' }) }.to raise_error(Maileon::Errors::ValidationError, "Invalid email format.") }
      it { expect { @maileon.create_contact({ :email => 'dummy@.2' }) }.to raise_error(Maileon::Errors::ValidationError, "Invalid email format.") }
      it { expect { @maileon.create_contact({ :email => '@dummy.de' }) }.to raise_error(Maileon::Errors::ValidationError, "Invalid email format.") }
    end
    context 'with valid email' do
     it { expect { @maileon.create_contact({ :email => 'dummy@email.com' }) }.not_to raise_error }
     it { expect { @maileon.create_contact({ :email => 'dummy@some.email.de' }) }.not_to raise_error }
     it { expect { @maileon.create_contact({ :email => 'dummy.some+filter@email.some-tld.de' }) }.not_to raise_error }
     it { expect(@maileon.create_contact({ :email => 'dummy@tld.de' }).status).to eq 200 }
    end
    context 'with invalid API key' do
     it {
       @maileon = Maileon::API.new('219049tigadkv9f095t03tk2')
       expect(@maileon.create_contact({ :email => 'dummy@tld.de' }).status).to eq 401
     }
    end
  end

  describe '.delete_contact' do
    before(:all) do
      @maileon = Maileon::API.new(MockMaileon::API_KEY)
    end
    context 'without parameters' do
      it { expect { @maileon.delete_contact() }.to raise_error(ArgumentError) }
    end
    context 'with empty parameters' do
      it { expect { @maileon.delete_contact({}) }.to raise_error(ArgumentError, "No parameters.") }
    end
    context 'without email' do
      it { expect { @maileon.delete_contact({:permission => 1}) }.to raise_error(ArgumentError, "Email is mandatory.") }
    end
    context 'with invalid email' do
      it { expect { @maileon.delete_contact({ :email => 'dummy@email' }) }.to raise_error(Maileon::Errors::ValidationError, "Invalid email format.") }
      it { expect { @maileon.delete_contact({ :email => 'dummy@email.2' }) }.to raise_error(Maileon::Errors::ValidationError, "Invalid email format.") }
      it { expect { @maileon.delete_contact({ :email => 'dummy@.2' }) }.to raise_error(Maileon::Errors::ValidationError, "Invalid email format.") }
      it { expect { @maileon.delete_contact({ :email => '@dummy.de' }) }.to raise_error(Maileon::Errors::ValidationError, "Invalid email format.") }
    end
    context 'with valid email' do
     it { expect { @maileon.delete_contact({ :email => 'dummy@email.com' }) }.not_to raise_error }
     it { expect { @maileon.delete_contact({ :email => 'dummy@some.email.de' }) }.not_to raise_error }
     it { expect { @maileon.delete_contact({ :email => 'dummy.some+filter@email.some-tld.de' }) }.not_to raise_error }
     it { expect(@maileon.delete_contact({ :email => 'dummy@tld.de' }).status).to eq 200 }
    end
    context 'with invalid API key' do
     it {
       @maileon = Maileon::API.new('219049tigadkv9f095t03tk2')
       expect(@maileon.delete_contact({ :email => 'dummy@tld.de' }).status).to eq 401
     }
    end
  end

end