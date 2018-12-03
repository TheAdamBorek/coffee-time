require 'rails_helper'

describe 'Video call' do
  it 'should route to update video call' do
    expect(post '/update_link').to route_to 'video_calls#update_link'
  end
end