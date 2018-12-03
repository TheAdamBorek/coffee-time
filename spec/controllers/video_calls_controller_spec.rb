require 'rails_helper'

RSpec.describe VideoCallsController, type: :controller do
  it 'should permit only text in params' do
    params = {
        text: "http://link.com",
        param_to_be_refused: "param_to_refuse"
    }
    should permit(:text).for(:update_link, params: params, verb: :post)
  end

  shared_examples('should_update_call_link') do

  end

  context 'when link is empty' do
    subject { post :update_link, params: {} }
    it 'should not updates the link' do
      create :video_call
      link = VideoCall.last.link
      subject
      expect(VideoCall.last.link).to eq(link)
    end
  end

  context 'when link is in params' do
    it 'response has a 200 OK status code' do
      subject
      expect(response).to have_http_status :ok
    end

    subject { post :update_link, params: {text: "http://link.com"} }
    it 'should updates the link' do
      create :video_call
      subject
      expect(VideoCall.last.link).to eq("http://link.com")
    end

    it 'render a response' do
      subject
      json = JSON.parse(response.body)
      expect(json['text']).to eq("I've changed the link to http://link.com")
    end
  end

  context 'when link is not an URI' do
    subject { post :update_link, params: {text: "not_valid"} }
    it 'should not update the link' do
      subject
      expect(VideoCall.instance.link).to_not eq("not_valid")
    end

    it 'should render an error' do
      subject
      json = JSON.parse(response.body)
      expect(json["text"]).to eq "Given text is not an URL"
      expect(response).to have_http_status :bad_request
    end
  end
end
