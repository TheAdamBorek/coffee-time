require 'rails_helper'

describe 'Video call' do
  it 'should route to update video call' do
    expect(put '/update_link').to route_to 'video_calls#update'
  end
end