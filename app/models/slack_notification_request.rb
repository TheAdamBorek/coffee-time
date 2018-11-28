class SlackNotificationRequest
  attr_reader :link_to_join
  include HttpRequest

  def initialize(link_to_join)
    @link_to_join = link_to_join
  end

  def url
    AppConfig.instance.slack_hook_url
  end

  def headers
    {"Content-Type": "application/json"}
  end

  def body
    {text: "<!here> Hey! Someone has just enter the coffee link. Don't let him drink coffee alone! Join now #{link_to_join}"}
  end

  def ==(other)
    @link_to_join == other.link_to_join
  end
end