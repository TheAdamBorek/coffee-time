require 'rails_helper'

describe 'Slack Notifier' do
  let(:sut) { SlackNotifier.new("dummy_url") }
  subject { sut.did_enter_hangouts }

  shared_examples_for "should_notify_slack" do
    before do
      ActiveJob::Base.queue_adapter = :test
    end

    it 'should notify slack about notification' do
      expect { subject }.to have_enqueued_job(NotifySlackJob)
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

  context("when last notification was no more than 1 hour ago") do
    before do
      create :slack_notification, last_notification_date: DateTime.now - 59.minutes
    end

    it "shouldn't make slack notification" do
      expect { subject }.to_not have_enqueued_job(NotifySlackJob)
    end
  end

  context("when last visit was earlier than 1 hour ago") do
    before do
      create :slack_notification, last_notification_date: DateTime.now - 1.hours - 1.seconds
    end
    it_behaves_like "should_notify_slack"
  end
end