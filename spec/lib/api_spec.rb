require 'spec_helper'

describe Maileon::API do

  it 'should throw error without API key' do
    expect { Maileon::API.new }.to raise_error
  end

  it 'should initilize with API key' do
    expect(Maileon::API.new('2iaodsfi4u83943uruqf')).to be_an_instance_of Maileon::API
  end

end