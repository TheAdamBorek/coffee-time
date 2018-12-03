require 'rails_helper'

RSpec.describe VideoCall, type: :model do
  it 'has a default value from config of video call' do
    call = VideoCall.new
    expect(call.link).to eq "https://tests.com/config_redirect"
  end

  it "default value shouldn't override value from DB" do
    create :video_call
    call = VideoCall.last
    expect(call.link).to_not eq "https://tests.com/config_redirect"
  end
end

