require 'spec_helper'

describe Maileon::API do
  it 'should initialise' do
    expect(Maileon::API.new).to be_an_instance_of Maileon::API
  end
end