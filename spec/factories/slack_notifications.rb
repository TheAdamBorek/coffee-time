FactoryBot.define do
  factory :slack_notification do
    last_notification_date { DateTime.now }
  end
end
