require 'rails_helper'

describe 'Slack Notifier' do
  let(:http) { double }
  let(:sut) { SlackNotifier.new("http://link_to_join.com", http) }
  subject { sut.did_enter_hangouts }

  shared_examples_for "should_notify_slack" do
    before do
      allow(http).to receive(:post)
    end

    it 'should notify slack about notification' do
      request = SlackNotificationRequest.new("http://link_to_join.com")
      expect(http).to receive(:post)
                          .with(request)
      subject
    end

    it 'should update last notification date' do
      subject
      notification = SlackNotification.last
      expect(notification.last_notification_date).to be_within(1.second).of DateTime.now
    end
  end

  context("when it's a first coffee visit") do
    it_behaves_like "should_notify_slack"
  end

  context("when last visit was in last 1 hour ago") do
    before do
      create :slack_notification, last_notification_date: DateTime.now - 59.minutes
    end

    it "shouldn't make slack notification" do
      expect(http).to_not receive(:post)
      subject
    end
  end

  context("when last visit was earlier than 1 hour ago") do
    before do
      create :slack_notification, last_notification_date: DateTime.now - 1.hours - 1.seconds
    end
    it_behaves_like "should_notify_slack"
  end
end