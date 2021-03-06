require 'rails_helper'

RSpec.describe CoffeeController, type: :controller do
  describe '#show' do
    let(:observer) { double }
    before do
      allow(observer).to receive(:did_enter_hangouts)
      allow(controller).to receive(:prepare_observers)
      controller.instance_variable_set(:@observers, [observer])
    end

    subject { get :show }
    it 'redirects to call link' do
      create :video_call
      expect(subject).to redirect_to 'https://link-factorybot.com'
    end

    it 'notifies observers about entry' do
      expect(observer).to receive(:did_enter_hangouts)
      subject
    end
  end
end