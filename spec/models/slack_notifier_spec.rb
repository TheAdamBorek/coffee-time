require 'rails_helper'

describe 'Slack Notifier' do
  let(:sut) { SlackNotifier.new("dummy_url") }
  let(:request_mock) { double }
  subject { sut.did_enter_hangouts(request_mock) }
  before do
    ActiveJob::Base.queue_adapter = :test
    allow(request_mock).to receive(:headers) { {"HTTP_USER_AGENT": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36"} }
  end

  shared_examples_for "notify_slack" do
    it 'should notify slack about notification' do
      expect { subject }.to have_enqueued_job(NotifySlackJob)
    end

    it 'should update last notification date' do
      subject
      notification = SlackNotification.last
      expect(notification.last_notification_date).to be_within(1.second).of DateTime.now
    end
  end

  shared_examples_for 'dont_notify_slack' do
    it 'doesnt scheduler notification job' do
      expect { subject }.to_not have_enqueued_job(NotifySlackJob)
    end

    it 'doesnt update last notification date' do
      old_date = SlackNotification.last.last_notification_date
      subject
      expect(SlackNotification.last.last_notification_date).to eq old_date
    end
  end

  context("when requests user-agent is slack's bot") do
    before do
      allow(request_mock).to receive(:headers) { {"HTTP_USER_AGENT": "Slackbot-LinkExpanding 1.0 (+https://api.slack.com/robots)"} }
    end
    it_behaves_like 'dont_notify_slack'
  end

  context("when it's a first coffee visit") do
    it_behaves_like "notify_slack"
  end

  context("when last visit was earlier than 1 hour ago") do
    before do
      create :slack_notification, last_notification_date: DateTime.now - 1.hours - 1.seconds
    end
    it_behaves_like "notify_slack"
  end

  context("when last notification was no more than 1 hour ago") do
    before do
      create :slack_notification, last_notification_date: DateTime.now - 59.minutes
    end
    it_behaves_like 'dont_notify_slack'
  end

end