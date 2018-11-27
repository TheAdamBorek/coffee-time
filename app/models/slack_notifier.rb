class SlackNotifier
  def initialize(http = HttpClient.new)
    @http = http
  end

  def did_enter_hangouts
    entry = SlackNotification.last
    if enter? entry, in_last: 1.hours
      update_entry_date_of entry
      notify_slack
    end
  end

  private

  def update_entry_date_of(entry)
    entry.last_notification_date = DateTime.now
    entry.save
  end

  def enter?(entry, in_last:)
    entry.last_notification_date < Time.now - in_last
  end

  def notify_slack
    @http.post(AppConfig.instance.slack_hook_url, body: {text: "The message"})
  end
end
