class NotifySlackJob < ApplicationJob
  queue_as :urgent

  def perform(root_url)
    http = HttpClient.new
    request = SlackNotificationRequest.new(root_url)
    http.post(request)
  end
end
