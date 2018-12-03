require 'rails_helper'

RSpec.describe VideoCallsController, type: :controller do
  it 'should permit only call_link in params' do
    params = {
        call_link: "https://call_link.com",
        param_to_be_refused: "param_to_refuse"
    }
    should permit(:call_link).for(:update, params: params)
  end

  shared_examples('should_update_call_link') do
    it 'should updates the call_link' do
      create :video_call
      subject
      expect(VideoCall.last.link).to eq(params[:call_link])
    end
  end

  context 'when link is empty' do
    let(:params) { {} }
    subject { put :update, params: {} }
    it_behaves_like 'should_update_call_link'
  end

  context 'when link is valid' do
    let(:params) { {call_link: "https://call_link.com"} }
    subject { put :update, params: params }
    it_behaves_like 'should_update_call_link'
  end
end
