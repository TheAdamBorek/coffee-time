class NotifySlackJob < ApplicationJob
  queue_as :urgent

  def perform
    http = HttpClient.new
    request = SlackNotificationRequest.new(root_url)
    http.post(request)
  end
end
