class SlackNotifier
  def initialize(root_url)
    @root_url = root_url
  end

  def did_enter_hangouts
    @notification = SlackNotification.last
    unless notified_in_last? 1.hours
      update_last_notification_date
      notify_slack
    end
  end

  private

  def update_last_notification_date
    @notification.last_notification_date = DateTime.now
    @notification.save
  end

  def notified_in_last?(time_ago)
    return false
    @notification.last_notification_date >= Time.now - time_ago
  end

  def notify_slack
    NotifySlackJob.perform_later @root_url
  end
end
