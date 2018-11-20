require 'rails_helper'

describe 'Coffee' do
  it 'should route to coffee' do
    expect(get '/').to route_to 'coffee#show'
  end
end