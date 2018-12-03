require 'rails_helper'

RSpec.describe VideoCall, type: :model do
  shared_examples_for "raise_url_format_error" do
    it "raises url format error" do
      expect { subject }.to raise_error(NotURLFormatError)
    end
  end

  it 'has a default value from config of video call' do
    call = VideoCall.new
    expect(call.link).to eq "https://tests.com/config_redirect"
  end

  it "default value shouldn't override value from DB" do
    create :video_call
    call = VideoCall.last
    expect(call.link).to_not eq "https://tests.com/config_redirect"
  end

  describe "#update_link" do
    context "it's not http or https" do
      subject { VideoCall.update_link("ftp://link.com") }
      it_behaves_like "raise_url_format_error"
    end

    context "it's not an URL" do
      subject { VideoCall.update_link("a normal string") }
      it_behaves_like "raise_url_format_error"
    end
  end
end

