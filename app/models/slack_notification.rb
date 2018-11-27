class SlackNotification < ApplicationRecord
  def self.last
    last_notification = super
    if last_notification.nil?
      last_notification = SlackNotification.new
      last_notification.last_notification_date = DateTime.new(1970, 1, 1)
    end
    last_notification
  end
end
