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
    {text: "Hey! Someone wants to drink some coffee together! Everyone is invited! #{link_to_join}"}
  end

  def ==(other)
    @link_to_join == other.link_to_join
  end
end