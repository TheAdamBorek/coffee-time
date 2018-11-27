class SlackNotifier
  def initialize(link_to_join, http = HttpClient.new)
    @http = http
    @link_to_join = link_to_join
  end

  def did_enter_hangouts
    notification = SlackNotification.last
    unless notified? notification, in_last: 1.hours
      update_entry_date_of notification
      notify_slack
    end
  end

  private

  def update_entry_date_of(entry)
    entry.last_notification_date = DateTime.now
    entry.save
  end

  def notified?(notification, in_last:)
    notification.last_notification_date >= Time.now - in_last
  end

  def notify_slack
    NotifySlackJob.perform_later
  end
end
