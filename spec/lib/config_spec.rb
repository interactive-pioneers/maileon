require 'spec_helper'
require 'excon'
require 'support/mock_maileon'

describe Maileon::Config do

  describe '.initialize' do

    context 'without options' do
      it { expect { Maileon::Config.new }.to raise_error(RuntimeError, "Configuration not found. Please ensure config/maileon.yml exists.") }
    end

    context 'with options' do
      it { expect(Maileon::Config.new({ :apikey => '90254jtbksdldgf85993', :debug => false })).to be_an_instance_of Maileon::Config }
    end

    context 'with YAML' do
      let(:apikey) { Base64.encode64('392050495049jkfdsggmb454u593').strip }
      before do
        Rails = OpenStruct.new({ env: 'test', root: 'spec/support/fixtures' })
        Maileon::Config.new
      end
      it { is_expected.to have_attributes(:apikey => apikey, :debug => false) }
    end

    context 'with environment variable' do
      let(:rawkey) { '4930tigsfkdgi9458ujfao' }
      let(:apikey) { Base64.encode64(rawkey).strip }
      before do
        ENV['MAILEON_API_KEY'] = rawkey
        Maileon::Config.new
      end
      it { is_expected.to have_attributes(:apikey => apikey, :debug => false) }
    end

  end

end
