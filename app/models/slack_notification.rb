class SlackNotification < ApplicationRecord
  after_initialize :set_default_notification_date

  def set_default_notification_date
    self.last_notification_date ||= DateTime.new(1970, 1, 1)
  end

  def self.last
    last_notification = super
    if last_notification.nil?
      last_notification = SlackNotification.new
    end
    last_notification
  end
end
