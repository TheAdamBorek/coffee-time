class SlackNotifier
  def initialize(root_url)
    @root_url = root_url
    @restricted_user_agents_words = ['slack']
  end

  def did_enter_hangouts(request)
    @notification = SlackNotification.last
    if is_human_request(request) && !notified_in_last?(1.hours)
      update_last_notification_date
      notify_slack
    end
  end

  private
  def is_human_request(request)
    user_agent = request.headers[:HTTP_USER_AGENT]
    return false if user_agent.nil?
    !contains_restricted_word(user_agent)
  end

  def contains_restricted_word(user_agent)
    user_agent = user_agent.downcase
    @restricted_user_agents_words.reduce(false) do |accumulator, restricted_word|
      word = restricted_word.downcase
      accumulator || user_agent.include?(word)
    end
  end

  def update_last_notification_date
    @notification.last_notification_date = DateTime.now
    @notification.save
  end

  def notified_in_last?(time_ago)
    @notification.last_notification_date >= Time.now - time_ago
  end

  def notify_slack
    NotifySlackJob.perform_later @root_url
  end
end
